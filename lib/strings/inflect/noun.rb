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
        if (matched = find_match(Inflect.configuration.singulars[:noun]))
          return matched
        end
        return word if word.to_s.empty? || uncountable?

        find_match(Nouns.singulars) || word
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
        if (matched = find_match(Inflect.configuration.plurals[:noun]))
          return matched
        end
        return word if word.to_s.empty? || uncountable?

        find_match(Nouns.plurals) || word
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
    end # Noun
  end # Inflect
end # Strings
