# frozen_string_literal: true

require "benchmark/ips"
require "active_support"

require_relative "../lib/strings-inflect"

Benchmark.ips do |bench|
  bench.report("active_support") do
    ActiveSupport::Inflector.pluralize("error")
  end

  bench.report("strings-inflect") do
    Strings::Inflect.pluralize("errors")
  end

  bench.compare!
end
