require "spec_helper"

RSpec.describe JsTextRails::SvgTransformer do
  before(:each) do
    @svg_transformer = JsTextRails::SvgTransformer.new
  end

  it "sanitizes a JS string" do
    expect(@svg_transformer.sanitize_js_string("What's up?")).to eq("What\\'s up?") # Still works.
    expect(@svg_transformer.sanitize_js_string("<?xml version=\"1.0\" encoding=\"utf-8\"?><svg></svg>")).to eq("<svg></svg>")
  end

  it "generates JS code" do
    expect(@svg_transformer.transform("icons/shape", "<svg></svg>")).to eq(
      <<-SVG
(function() { this.SVG || (this.SVG = {}); this.SVG['icons/shape'] = '<svg></svg>';
}).call(this);
      SVG
    )
  end
end
