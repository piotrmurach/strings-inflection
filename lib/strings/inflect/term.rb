# frozen_string_literal: true

module Strings
  module Inflect
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

      def find_match(rules)
        regex, replacement = rules.find { |rule| !!(word =~ rule[0]) }

        return word if regex.nil?

        word.sub(regex, replacement)
      end

      # A string representation of this term
      #
      # @api public
      def to_s
        word.to_s
      end
    end # Term
  end # Inflect
end # Strings
