# frozen_string_literal: true

require "benchmark/ips"
require "active_support"

require_relative "../lib/strings-inflection"

Benchmark.ips do |bench|
  bench.report("active_support") do
    ActiveSupport::Inflector.pluralize("error")
  end

  bench.report("strings-inflection") do
    Strings::Inflection.pluralize("error")
  end

  bench.compare!
end
