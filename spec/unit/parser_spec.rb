# frozen_string_literal: true

RSpec.describe Strings::Inflection::Parser do
  context "noun" do
    it "inflects a noun" do
      expect(Strings::Inflection::Parser.parse("{{N:error}}", 2)).to eq("errors")
    end

    it "applies singular modifier" do
      expect(Strings::Inflection::Parser.parse("{{Ns:error}}", 2)).to eq("error")
    end

    it "applies plural modifier" do
      expect(Strings::Inflection::Parser.parse("{{Np:error}}", 1)).to eq("errors")
    end

    it "allows for space between separator" do
      expect(Strings::Inflection::Parser.parse("{{N  p :  error   }}", 2)).to eq("errors")
    end

    it "allows uppercase for modifiers" do
      expect(Strings::Inflection::Parser.parse("{{N  S :  error   }}", 2)).to eq("error")
    end

    it "fails to recognise tag modifier var" do
      template = "{{Nu:error}}"

      expect {
        Strings::Inflection::Parser.parse(template, 2)
      }.to raise_error("Unknown option 'u' in {{N:...}} tag")
    end
  end

  context "verb" do
    it "inflects a verb" do
      expect(Strings::Inflection::Parser.parse("{{V:tries}}", 2)).to eq("try")
    end

    it "allows for space between separator" do
      expect(Strings::Inflection::Parser.parse("{{V  :   tries  }}", 2)).to eq("try")
    end

    it "fails to recognise tag modifier var" do
      template = "{{Vu:error}}"

      expect {
        Strings::Inflection::Parser.parse(template, 2)
      }.to raise_error("Unknown option 'u' in {{V:...}} tag")
    end
  end

  context "count" do
    it "fails to recognise # template var" do
      template = "{{#u:count}}"

      expect {
        Strings::Inflection::Parser.parse(template, 2)
      }.to raise_error("Unknown option 'u' in {{#:...}} tag")
    end

    it "counts with number as cardinal words" do
      expect(Strings::Inflection::Parser.parse("{{#w: count}}", 12)).to eq("twelve")
    end

    it "counts with number as cardinal words up to the limit" do
      expect(Strings::Inflection::Parser.parse("{{#w10: count}}", 12)).to eq("12")
    end

    it "counts with a short ordinal" do
      expect(Strings::Inflection::Parser.parse("{{#o: count}}", 12)).to eq("12th")
    end

    it "counts with an ordinal" do
      expect(Strings::Inflection::Parser.parse("{{# o w : count}}", 12)).to eq("twelfth")
    end
  end

  context "count fuzzy" do
    it "allows for space between separator" do
      expect(Strings::Inflection::Parser.parse("{{# f  :  count   }}", 0)).to eq("no")
    end

    it "allows for capital letter" do
      expect(Strings::Inflection::Parser.parse("{{#F:count}}", 0)).to eq("no")
    end

    it "changes 0 count to no " do
      expect(Strings::Inflection::Parser.parse("{{#f:count}}", 0)).to eq("no")
    end

    it "changes 1 count to one" do
      expect(Strings::Inflection::Parser.parse("{{#f:count}}", 1)).to eq("one")
    end

    it "changes 2 count to 'a couple of'" do
      expect(Strings::Inflection::Parser.parse("{{#f:count}}", 2)).to eq("a couple of")
    end

    it "changes 4 count to 'a few'" do
      expect(Strings::Inflection::Parser.parse("{{#f:count}}", 4)).to eq("a few")
    end

    it "changes 8 count to 'several'" do
      expect(Strings::Inflection::Parser.parse("{{#f:count}}", 8)).to eq("several")
    end

    it "changes 10 count to 'many'" do
      expect(Strings::Inflection::Parser.parse("{{#f:count}}", 10)).to eq("many")
    end
  end
end
