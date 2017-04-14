require "spec_helper"

RSpec.describe JsTextRails::TextTransformer do
  it "sanitizes a JS string" do
    text_transformer = JsTextRails::TextTransformer.new
    expect(text_transformer.sanitize_js_string("What's up?")).to eq("What\\'s up?")
  end
end
