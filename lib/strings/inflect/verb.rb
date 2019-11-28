# frozen_string_literal: true

require_relative "verbs"

module Strings
  module Inflect
    class Verb
      def self.[](word)
        self.new(word)
      end

      attr_reader :word

      # Create a new verb
      #
      # @param [String] word
      #   the word to turn into a verb object
      #
      # @api public
      def initialize(word)
        @word = word.dup
      end

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
      #   Strings::Inflect::Verb.new("go").singular
      #   # => "goes"
      #
      # @param [String] word
      #   the noun to inflect to singular form
      #
      # @api public
      def singular
        return word if word.to_s.empty? || uninflected?

        regex, replacement = Verbs.singulars.find { |rule| !!(word =~ rule[0]) }

        return word if regex.nil?

        word.sub(regex, replacement)
      end

      # Inflect a word to its plural form
      #
      # @example
      #   Strings::Inflect::Verb.new("goes").plural
      #   # => "go"
      #
      # @param [String] word
      #   noun to inflect to plural form
      #
      # @api public
      def plural
        return word if word.to_s.empty? || uninflected?

        regex, replacement = Verbs.plurals.find { |rule| !!(word =~ rule[0]) }

        return word if regex.nil?

        word.sub(regex, replacement)
      end
    end # Verb
  end # Inflect
end # Strings
