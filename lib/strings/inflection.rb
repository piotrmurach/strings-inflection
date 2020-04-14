# frozen_string_literal: true
require "forwardable"

require_relative "inflection/inflector"
require_relative "inflection/version"

module Strings
  module Inflection
    # Error raised by this inflector
    class Error < StandardError; end

    class << self
      extend Forwardable

      def_delegators :global, *(Inflection::Inflector.instance_methods - Inflection.methods)

      def global
        @global ||= Inflector.new
      end
    end
  end # Inflection
end # Strings
