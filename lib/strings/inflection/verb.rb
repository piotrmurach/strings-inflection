# frozen_string_literal: true

require_relative "term"
require_relative "verbs"

module Strings
  module Inflection
    class Verb < Term
      # Check if word is uninflected
      #
      # @param [String] word
      #   the word to check
      #
      # @return [Boolean]
      #
      # @api private
      def uninflected?
        Verbs.uninflected.include?(word)
      end

      # Inflect a word to its singular form
      #
      # @example
      #   Strings::Inflection::Verb.new("go").singular
      #   # => "goes"
      #
      # @return [String]
      #   the verb inflected to singular form
      #
      # @api public
      def singular
        return word if word.to_s.empty? || uninflected?

        find_match(Verbs.singulars) || word
      end

      # Inflect a word to its plural form
      #
      # @example
      #   Strings::Inflection::Verb.new("goes").plural
      #   # => "go"
      #
      # @return [String]
      #   the verb inflected to plural form
      #
      # @api public
      def plural
        return word if word.to_s.empty? || uninflected?

        find_match(Verbs.plurals) || word
      end
    end # Verb
  end # Inflection
end # Strings
