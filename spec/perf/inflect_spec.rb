# frozen_string_literal: true

require "rspec-benchmark"
require "active_support"

RSpec.describe Strings::Inflection do
  include RSpec::Benchmark::Matchers

  it "pluralizes nouns as fast as ActiveSupport" do
    expect {
      Strings::Inflection.pluralize("error")
    }.to perform_slower_than {
      ActiveSupport::Inflector.pluralize("error")
    }.at_most(1.6).times
  end

  it "singularizes nouns as fast as ActiveSupport" do
    expect {
      Strings::Inflection.singularize("errors")
    }.to perform_slower_than {
      ActiveSupport::Inflector.singularize("errors")
    }.at_most(1.8).times
  end

  it "allocates no more than 40 objects" do
    expect {
      Strings::Inflection.pluralize("error")
    }.to perform_allocation(40)
  end
end
