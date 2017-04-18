require 'spec_helper'

describe JsController, type: :controller do
  before :all do
    cache = Rails.root.join('tmp/cache')
    cache.rmtree if cache.exist?
  end

  def test_file(file)
    if Rails.version.split('.').first.to_i >= 5
      get :test, params: { file: file }
    else
      get :test, file: file
    end
  end

  it "integrates with Rails and JS" do
    test_file 'application'
    expect(response).to be_success
    clear_js = response.body
    expect(clear_js).to eq (
      <<-TEXT
(function() { this.SVG || (this.SVG = {}); this.SVG['icons/circle'] = '<svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">\\n  <circle cx="100" cy="100" r="100"/>\\n</svg>\\n';
}).call(this);
      TEXT
    )
  end
end
