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

  it "allocates" do
    expect {
      Strings::Inflection.pluralize("error")
    }.to perform_allocation(40)
  end
end
