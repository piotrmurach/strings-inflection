# frozen_string_literal: true

RSpec.describe Strings::Inflection, "#inflect" do
  it "inflects plural word to singular" do
    expect(Strings::Inflection.inflect("doors", 1)).to eq("door")
  end

  it "leaves plural uninflected" do
    expect(Strings::Inflection.inflect("doors", 2)).to eq("doors")
  end

  it "inflects singular word to plural" do
    expect(Strings::Inflection.inflect("door", 2)).to eq("doors")
  end

  it "leaves singular word uninflected" do
    expect(Strings::Inflection.inflect("door", 1)).to eq("door")
  end

  it "inflects singular verb" do
    expect(Strings::Inflection.inflect("tries", 2, term: :verb)).to eq("try")
  end

  it "inflects plural verb" do
    expect(Strings::Inflection.inflect("try", 1, term: :verb)).to eq("tries")
  end

  it "uses template vars" do
    template = "{{#:count}} {{N:error}} {{V:was}} found"

    expect(Strings::Inflection.inflect(template, 2)).to eq("2 errors were found")
  end

  it "uses template vars in plural" do
    template = "{{#:count}} {{N:errors}} {{V:was}} found"

    expect(Strings::Inflection.inflect(template, 1)).to eq("1 error was found")
  end

  it "allows to force template singular form" do
    template = "{{#:count}} {{Ns:error}} {{V:was}} found"

    expect(Strings::Inflection.inflect(template, 2)).to eq("2 error were found")
  end

  it "changes template count to fuzzy amount " do
    template = "{{#f:count}} {{N:error}} {{V:was}} found"

    expect(Strings::Inflection.inflect(template, 2)).to eq("a couple of errors were found")
  end

  it "changes template count to use words for a number" do
    template = "{{#w:count}} {{N:error}} {{V:was}} found"

    expect(Strings::Inflection.inflect(template, 2)).to eq("two errors were found")
  end

  it "changes template count to use ordinal words for a number" do
    template = "{{#wo:count}} {{Ns:result}}"

    expect(Strings::Inflection.inflect(template, 2)).to eq("second result")
  end
end
