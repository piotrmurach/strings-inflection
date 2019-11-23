# frozen_string_literal: true

RSpec.describe Strings::Inflect, "#join_words" do
  it "returns empty string nil" do
    expect(Strings::Inflect.join_words).to eq("")
  end

  it "returns empty string when no words" do
    expect(Strings::Inflect.join_words([])).to eq("")
  end

  it "joins a single word" do
    expect(Strings::Inflect.join_words("one")).to eq("one")
  end

  it "joins two words" do
    expect(Strings::Inflect.join_words("one", "two")).to eq("one and two")
  end

  it "joins three words with oxford style comma" do
    expect(Strings::Inflect.join_words("one", "two", "three")).to eq("one, two, and three")
  end

  it "joins three words without oxford style comma" do
    expect(Strings::Inflect.join_words("one", "two", "three", final_separator: ""))
      .to eq("one, two and three")
  end

  it "joins three words with custom conjunctive" do
    expect(Strings::Inflect.join_words("one", "two", "three", conjunctive: "or"))
      .to eq("one, two, or three")
  end

  it "joins words with custom separators" do
    options = {
      separator: " or ",
      final_separator: " or at least ",
      conjunctive: ""
    }
    expect(Strings::Inflect.join_words("one", "two", "three", **options))
      .to eq("one or two or at least three")
  end

  it "collapses whitespace between two words" do
    expect(Strings::Inflect.join_words("   one   ", "    two   "))
      .to eq(" one and two ")
  end

  it "collapses any whitespace" do
    expect(Strings::Inflect.join_words("   one   ", "    two   ", "    three    "))
      .to eq(" one, two, and three ")
  end
end
