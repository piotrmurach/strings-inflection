# frozen_string_literal: true

RSpec.describe Strings::Inflection::Inflector do
  before do
    instance_1.configure do |config|
      config.plural "index", "indexes"
    end
  end

  let(:instance_1) {
    described_class.new
  }

  let(:instance_2) {
    described_class.new
  }

  it "isolates its configuration from other instances" do
    expect(instance_1.pluralize("index")).to eq("indexes")
    expect(instance_2.pluralize("index")).to eq("indices")
  end

  it "isolates its configuration from the global instance" do
    expect(Strings::Inflection.pluralize("index")).to eq("indices")
  end
end
