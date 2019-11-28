# frozen_string_literal: true

if ENV["COVERAGE"] || ENV["TRAVIS"]
  require "simplecov"
  require "coveralls"

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ])

  SimpleCov.start do
    command_name "spec"
    add_filter "spec"
  end
end

require "bundler/setup"
require "strings/inflect"

module Helpers
  def gem_root
    ::File.join(File.dirname(__FILE__), "..")
  end

  def dir_path(*args)
    path = ::File.join(gem_root, *args)
    ::FileUtils.mkdir_p(path) unless ::File.exist?(path)
    ::File.realpath(path)
  end

  def fixtures_path(*args)
    ::File.join(dir_path('spec', 'fixtures'), *args)
  end

  def inflections_example(*args)
    file = fixtures_path(*args)
    ::File.foreach(file) do |line|
      if !line.tr(" ", "").chomp.empty? && !line.start_with?("#")
        yield(*line.split.map(&:chomp))
      end
    end
  end
end

RSpec.configure do |config|
  config.extend(Helpers)
  config.include(Helpers)

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
