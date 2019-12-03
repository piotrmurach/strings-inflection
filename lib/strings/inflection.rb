# frozen_string_literal: true
require_relative "inflection/combined_noun"
require_relative "inflection/configuration"
require_relative "inflection/noun"
require_relative "inflection/parser"
require_relative "inflection/verb"
require_relative "inflection/version"

module Strings
  module Inflection
    # Error raised by this inflector
    class Error < StandardError; end

    # Create a noun object
    #
    # @api public
    def Noun(word)
      Noun[word]
    end
    module_function :Noun

    # Create a verb object
    #
    # @api public
    def Verb(word)
      Verb[word]
    end
    module_function :Verb

    # A configuration object
    #
    # @api public
    def configuration
      @configuration ||= Configuration.new
    end
    module_function :configuration

    # Reset configuration and remove loaded inflections
    #
    # @api public
    def reset(scope = :all)
      configuration.reset(scope)
    end
    module_function :reset

    # Configure custom inflections
    #
    # @example
    #   configure do |config|
    #     config.plural "index", "indexes"
    #     config.singular "axes", "ax"
    #   end
    #
    # @api public
    def configure
      if block_given?
        yield configuration
      else
        configuration
      end
    end
    module_function :configure

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
    #   Strings::Inflection.inflect("error", 3)
    #   # => "errors"
    #
    # @param [String] word
    #   the word to inflect
    # @param [Integer] count
    #   the count of items
    #
    # @api public
    def inflect(word, count, term: :noun)
      template = !!(word =~ /\{\{([^\}]+)\}\}/)

      Parser.parse(template ? word : "{{#{term.upcase[0]}:#{word}}}", count)
    end
    module_function :inflect

    # Inflect a pural word to its singular form
    #
    # @example
    #   Strings::Inflection.singularize("errors")
    #   # => "error"
    #
    # @param [String] word
    #   the noun to inflect to singular form
    #
    # @api public
    def singularize(word, term: :noun)
      case term
      when :noun, :n
        Noun[word].singular
      when :verb, :v
        Verb[word].singular
      end
    end
    module_function :singularize

    # Inflect a word to its plural form
    #
    # @example
    #   Strings::Inflection.pluralize("error")
    #   # => "errors"
    #
    # @param [String] word
    #   noun to inflect to plural form
    #
    # @api public
    def pluralize(word, term: :noun)
      case term
      when :noun, :n
        Noun[word].plural
      when :verb, :v
        Verb[word].plural
      end
    end
    module_function :pluralize

    # Check if noun is in singular form
    #
    # @example
    #   Strings::Inflection.singular?("error")
    #   # => true
    #
    # @return [Boolean]
    #
    # @api public
    def singular?(word, term: :noun)
      case term.to_sym
      when :noun, :n
        Noun[word].singular?
      when :verb, :v
        Verb[word].singular?
      else
        raise Error, "Unknown option '#{term}' as a term"
      end
    end
    module_function :singular?

    # Check if noun is in plural form
    #
    # @example
    #   Strings::Inflection.plural?("errors")
    #   # => true
    #
    # @return [Boolean]
    #
    # @api public
    def plural?(word, term: :noun)
      case term.to_sym
      when :noun, :n
        Noun[word].plural?
      when :verb, :v
        Verb[word].plural?
      else
        raise Error, "Unknown option '#{term}' as a term"
      end
    end
    module_function :plural?


    # Join a list of words into a single sentence
    #
    # @example
    #   Strings::Inflection.join_words("one", "two", "three")
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
    def join_words(*words, **options)
      CombinedNoun.new(words).join_words(**options)
    end
    module_function :join_words
  end # Inflection
end # Strings
