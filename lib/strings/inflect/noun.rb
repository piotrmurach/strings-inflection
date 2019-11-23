# frozen_string_literal: true

require_relative "nouns"

module Strings
  module Inflect
    class Noun
      def self.[](word)
        self.new(word)
      end

      attr_reader :word

      # Create a new noun
      #
      # @param [String] word
      #   the word to turn into a noun object
      #
      # @api public
      def initialize(word)
        @word = word.dup
      end

      # Check if word is uncountable
      #
      # @param [String] word
      #   the word to check
      #
      # @return [Boolean]
      #
      # @api private
      def uncountable?
        Nouns.uncountable.include?(word)
      end

      # Inflect a word to its singular form
      #
      # @example
      #   Strings::Inflect::Noun.new("errors").singular
      #   # => "error"
      #
      # @param [String] word
      #   the noun to inflect to singular form
      #
      # @api public
      def singular
        return word if word.to_s.empty? || uncountable?

        regex, replacement = Nouns.singulars.find { |rule| !!(word =~ rule[0]) }

        return word if regex.nil?

        word.sub(regex, replacement)
      end

      # Inflect a word to its plural form
      #
      # @example
      #   Strings::Inflect.pluralize("error")
      #   # => "errors"
      #
      # @param [String] word
      #   noun to inflect to plural form
      #
      # @api public
      def plural
        return word if word.to_s.empty? || uncountable?

        regex, replacement = Nouns.plurals.find { |rule| !!(word =~ rule[0]) }

        return word if regex.nil?

        word.sub(regex, replacement)
      end

      # Check if noun is in singular form
      #
      # @example
      #   Strings::Inflect::Noun.new("error").singular?
      #   # => true
      #
      # @return [Boolean]
      #
      # @api public
      def singular?
        return false if word.to_s.empty?

        word == singular
      end

      # Check if noun is in plural form
      #
      # @example
      #   Strings::Inflect::Noun.new("errors").plural?
      #   # => true
      #
      # @return [Boolean]
      #
      # @api public
      def plural?
        return false if word.to_s.empty?

        word == plural
      end

      # A string representation of this word
      #
      # @api public
      def to_s
        word.to_s
      end
    end # Noun
  end # Inflect
end # Strings
