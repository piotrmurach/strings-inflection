# frozen_string_literal: true

module Strings
  module Inflection
    class CombinedNoun
      WHITESPACE_REGEX = /(\s)\s+/.freeze

      attr_reader :words

      # Create a combined noun
      #
      # @api private
      def initialize(words = [])
        @words = words
      end

      # Combined with another noun
      #
      # @param [String] word
      #   the word to combine with
      #
      # @api public
      def +(word)
        CombinedNoun.new(@words + [word])
      end

      # Join a list of words into a single sentence
      #
      # @example
      #   CombinedNoun(["one", "two", "three"]).join_words
      #   # => "one, two and three"
      #
      # @param [Array[String]] words
      #   the words to join
      # @param [String] separator
      #   the character to use to join words, defaults to `,`
      # @param [String] final_separator
      #   the separator used before joining the last word
      # @param [String] conjunctive
      #   the word used for combining the last word with the rest
      #
      # @return [String]
      #
      # @api public
      def join_words(separator: ", ", conjunctive: "and", final_separator: nil)
        oxford_comma = final_separator || separator

        case words.length
        when 0
          ""
        when 1, 2
          words.join(" #{conjunctive} ").gsub(WHITESPACE_REGEX, "\\1")
        else
          ((words[0...-1]).join(separator.to_s) +
          "#{oxford_comma} #{conjunctive} " + words[-1])
            .gsub(WHITESPACE_REGEX, "\\1").gsub(/\s*(,)/, "\\1")
        end
      end

      # The combined words
      #
      # @return [Array[String]]
      #
      # @api public
      def to_ary
        @words.to_ary
      end
    end # CombinedNoun
  end # Inflection
end # Strings
