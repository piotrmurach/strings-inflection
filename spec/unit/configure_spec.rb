# frozen_string_literal: true

RSpec.describe Strings::Inflection, "#configure" do
  it "overrides built-in plural noun inflections" do
    Strings::Inflection.configure do |config|
      config.plural "index", "indexes"
    end

    expect(Strings::Inflection.inflect("index", 3)).to eq("indexes")

    Strings::Inflection.reset
  end

  it "overrides built-in singular noun inflections" do
    Strings::Inflection.configure do |config|
      config.singular "axes", "ax"
    end

    expect(Strings::Inflection.inflect("axes", 1)).to eq("ax")

    Strings::Inflection.reset
  end

  it "overrides built-in noun singular & plural inflections" do
    Strings::Inflection.configure do |config|
      config.rule "ax", "axes"
    end

    expect(Strings::Inflection.inflect("ax", 2)).to eq("axes")
    expect(Strings::Inflection.inflect("axes", 1)).to eq("ax")

    Strings::Inflection.reset
  end

  it "overrides built-in noun uncountable inflections" do
    Strings::Inflection.configure do |config|
      config.uncountable "index"
    end

    expect(Strings::Inflection.inflect("index", 2)).to eq("index")

    Strings::Inflection.reset
  end
end
