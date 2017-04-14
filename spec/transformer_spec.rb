require "spec_helper"

RSpec.describe JsTextRails do
  it "creates an escaped JS string" do
    expect(JsTextRails.transform("What's up?")).to eq("'What\\'s up?'")
  end
end
