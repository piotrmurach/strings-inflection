# frozen_string_literal: true

module Strings
  module Inflect
    class Configuration

      attr_reader :plurals, :singulars, :uncountables

      # Initialize a configuration
      #
      # @api private
      def initialize
        reset
      end

      # Add a singular rule form for a term. By default noun.
      #
      # @example
      #   singular "axes", "ax"
      #
      # @param [String,Regex] rule
      # @param [String] replacement
      #
      # @api public
      def singular(rule, replacement, term: :noun)
        @singulars[term] << [Regexp.new(rule, "i"), replacement]
      end

      # Add a plural rule form for a term. By default noun.
      #
      # @example
      #   plural "index", "indexes"
      #
      # @param [String,Regex] rule
      # @param [String] replacement
      #
      # @api public
      def plural(rule, replacement, term: :noun)
        @plurals[term] << [Regexp.new(rule, "i"), replacement]
      end

      # Add a rule that provides transformation for both singular and
      # plural inflections.
      #
      # @example
      #   rule "ax", "axes"
      #
      # @api public
      def rule(sing, plur, term: :noun)
        plural(sing, plur, term: term)
        singular(plur, sing, term: term)
      end

      # Add an uncountable word. By default noun.
      #
      # @api public
      def uncountable(word, term: :noun)
        @uncountables[term] << word
      end

      # Reset configuration and remove loaded inflections. By default
      # all scopes are reset. The available scopes are: :plurals,
      # :singulars, :uncountable
      #
      # @example
      #   reset(:all)
      #   reset(:plurals)
      #
      # @api public
      def reset(scope = :all)
        case scope
        when :all
          %i[singulars plurals uncountables].map {|s| clear(s) }
        else
          clear(scope)
        end
      end

      def clear(name)
        instance_variable_set "@#{name}", { noun: [], verb: [] }
      end
    end # Configuration
  end # Inflect
end # Strings
