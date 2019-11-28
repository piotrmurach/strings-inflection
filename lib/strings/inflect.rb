# frozen_string_literal: true

require_relative "inflect/noun"
require_relative "inflect/verb"
require_relative "inflect/version"

module Strings
  module Inflect
    def Noun(word)
      Noun[word]
    end
    module_function :Noun

    def Verb(word)
      Verb[word]
    end
    module_function :Verb

    # Check if word is uncountable
    #
    # @param [String] word
    #   the word to check
    #
    # @return [Boolean]
    #
    # @api private
    def uncountable?(word)
      Noun[word].uncountable?
    end
    module_function :uncountable?

    # Inflect a noun into a correct form
    #
    # @example
    #   Strings::Inflect.inflect("error", 3)
    #   # => "errors"
    #
    # @param [String] word
    #   the word to inflect
    # @param [Integer] count
    #   the count of items
    #
    # @api public
    def inflect(word, count, term: :noun)
      if count == 1
        singularize(word, term: term)
      else
        pluralize(word, term: term)
      end
    end
    module_function :inflect

    # Inflect a pural word to its singular form
    #
    # @example
    #   Strings::Inflect.singularize("errors")
    #   # => "error"
    #
    # @param [String] word
    #   the noun to inflect to singular form
    #
    # @api public
    def singularize(word, term: :noun)
      case term
      when :noun
        Noun[word].singular
      when :verb
        Verb[word].singular
      end
    end
    module_function :singularize

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
    def pluralize(word, term: :noun)
      case term
      when :noun
        Noun[word].plural
      when :verb
        Verb[word].plural
      end
    end
    module_function :pluralize

    # Check if noun is in singular form
    #
    # @example
    #   Strings::Inflect.singular?("error")
    #   # => true
    #
    # @return [Boolean]
    #
    # @api public
    def singular?(word)
      Noun[word].singular?
    end
    module_function :singular?

    # Check if noun is in plural form
    #
    # @example
    #   Strings::Inflect.plural?("errors")
    #   # => true
    #
    # @return [Boolean]
    #
    # @api public
    def plural?(word)
      Noun[word].plural?
    end
    module_function :plural?

    WHITESPACE_REGEX = /(\s)\s+/.freeze

    # Join a list of words into a single sentence
    #
    # @example
    #   Strings::Inflect.join_words("one", "two", "three")
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
    def join_words(*words, separator: ", ", conjunctive: "and", final_separator: nil)
      oxford_comma = final_separator || separator

      case words.length
      when 0
        ""
      when 1, 2
        words.join(" #{conjunctive} ").gsub(WHITESPACE_REGEX, "\\1")
      else
        ((words[0...-1]).join("#{separator}") +
         "#{oxford_comma} #{conjunctive} " + words[-1])
          .gsub(WHITESPACE_REGEX, "\\1").gsub(/\s*(,)/, "\\1")
      end
    end
    module_function :join_words
  end # Inflect
end # Strings
