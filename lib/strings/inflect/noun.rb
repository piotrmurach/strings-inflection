# frozen_string_literal: true

require_relative "term"
require_relative "nouns"

module Strings
  module Inflect
    class Noun < Term
      # Check if word is uncountable
      #
      # @param [String] word
      #   the word to check
      #
      # @return [Boolean]
      #
      # @api private
      def uncountable?
        Inflect.configuration.uncountables[:noun].include?(word.downcase) ||
          Nouns.uncountable.include?(word.downcase)
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
        return word if word.to_s.empty?

        find_match(Inflect.configuration.singulars[:noun]) ||
          (uncountable? && word) || find_match(Nouns.singulars) || word
      end

      # Inflect a word to its plural form
      #
      # @example
      #   Strings::Inflect::Noun.new("error").plural
      #   # => "errors"
      #
      # @param [String] word
      #   noun to inflect to plural form
      #
      # @api public
      def plural
        return word if word.to_s.empty?

        find_match(Inflect.configuration.plurals[:noun]) ||
          (uncountable? && word) || find_match(Nouns.plurals) || word
      end
    end # Noun
  end # Inflect
end # Strings
