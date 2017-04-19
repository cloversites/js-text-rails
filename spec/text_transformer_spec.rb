require 'spec_helper'

describe JsTextRails::TextTransformer do
  before(:each) do
    @text_transformer = JsTextRails::TextTransformer.new
  end

  it "sanitizes a JS string" do
    expect(@text_transformer.sanitize_js_string("What's up?")).to eq("What\\'s up?")
    expect(@text_transformer.sanitize_js_string("Enter the directory C:\\Users.")).to eq("Enter the directory C:\\\\Users.")
    expect(@text_transformer.sanitize_js_string("\f\b\n\t\r\u2028\u2029")).to eq('\f\b\n\t\r\u2028\u2029') # Note the quotes.
  end

  it "generates JS code" do
    expect(@text_transformer.transform("question\\state-of-being", "How are you?")).to eq(
      <<-TEXT
(function() { this.TEXT || (this.TEXT = {}); this.TEXT['question\\\\state-of-being'] = 'How are you?';
}).call(this);
      TEXT
    )
  end

  it "customizes the namespace" do
    @text_transformer = JsTextRails::TextTransformer.new(namespace: 'App.Text')
    expect(@text_transformer.transform("key", "value")).to eq(
      <<-TEXT
(function() { App.Text || (App.Text = {}); App.Text['key'] = 'value';
}).call(this);
      TEXT
    )
  end
end
