# frozen_string_literal: true

module Strings
  module Inflection
    class Term
      # Create a term
      #
      # @api public
      def self.[](word)
        self.new(word)
      end

      attr_reader :word

      # Create a new term
      #
      # @param [String] word
      #   the word to turn into a term object
      #
      # @api public
      def initialize(word)
        @word = word.dup
        freeze
      end

      # Find a matching rule and replace
      #
      # @return [nil, String]
      #  nil or replaced word
      #
      # @api private
      def find_match(rules)
        regex, replacement = rules.find { |rule| !!(word =~ rule[0]) }

        return if regex.nil?

        word.sub(regex, replacement)
      end

      # Check if noun is in singular form
      #
      # @example
      #   Strings::Inflection::Noun.new("error").singular?
      #   # => true
      #
      # @return [Boolean]
      #
      # @api public
      def singular?
        return false if word.to_s.empty?

        word.downcase == singular
      end

      # Check if noun is in plural form
      #
      # @example
      #   Strings::Inflection::Noun.new("errors").plural?
      #   # => true
      #
      # @return [Boolean]
      #
      # @api public
      def plural?
        return false if word.to_s.empty?

        word.downcase == plural
      end

      # A string representation of this term
      #
      # @api public
      def to_s
        word.to_s
      end
    end # Term
  end # Inflection
end # Strings
