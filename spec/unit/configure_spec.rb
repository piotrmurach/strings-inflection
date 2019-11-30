# frozen_string_literal: true

RSpec.describe Strings::Inflect, "#configure" do
  it "overrides built-in plural noun inflections" do
    Strings::Inflect.configure do |config|
      config.plural "index", "indexes"
    end

    expect(Strings::Inflect.inflect("index", 3)).to eq("indexes")

    Strings::Inflect.reset
  end

  it "overrides built-in singular noun inflections" do
    Strings::Inflect.configure do |config|
      config.singular "axes", "ax"
    end

    expect(Strings::Inflect.inflect("axes", 1)).to eq("ax")

    Strings::Inflect.reset
  end

  it "overrides built-in noun singular & plural inflections" do
    Strings::Inflect.configure do |config|
      config.rule "ax", "axes"
    end

    expect(Strings::Inflect.inflect("ax", 2)).to eq("axes")
    expect(Strings::Inflect.inflect("axes", 1)).to eq("ax")

    Strings::Inflect.reset
  end

  it "overrides built-in noun uncountable inflections" do
    Strings::Inflect.configure do |config|
      config.uncountable "index"
    end

    expect(Strings::Inflect.inflect("index", 2)).to eq("index")

    Strings::Inflect.reset
  end
end
