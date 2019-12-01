# frozen_string_literal: true

require "strings/inflect/extensions"

using Strings::Inflect::Extensions

RSpec.describe Strings::Inflect::Extensions do
  it "inflects a noun" do
    expect("error".inflect(2)).to eq("errors")
  end

  it "inflects a verb" do
    expect("match".inflect(1, term: :verb)).to eq("matches")
  end

  it "singularizes a noun" do
    expect("errors".singularize).to eq("error")
  end

  it "singularizes a verb" do
    expect("match".singularize(term: :verb)).to eq("matches")
  end

  it "pluralizes a noun" do
    expect("error".pluralize).to eq("errors")
  end

  it "pluralizes a verb" do
    expect("matches".pluralize(term: :verb)).to eq("match")
  end

  it "checks if a noun is singular" do
    expect("error".singular?).to eq(true)
  end

  it "checks if a verb is singular" do
    expect("matches".singular?(term: :verb)).to eq(true)
  end

  it "checks if a noun is plural" do
    expect("errors".plural?).to eq(true)
  end

  it "checks if a verb is plural" do
    expect("match".plural?(term: :verb)).to eq(true)
  end

  it "joins words" do
    expect("one".join_words("two", "three")).to eq("one, two, and three")
  end
end
