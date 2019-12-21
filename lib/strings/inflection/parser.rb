# frozen_string_literal: true

require "strscan"

require_relative "noun"

module Strings
  module Inflection
    class Parser
      # Parse a string by evaluating content inside tags
      #
      # @api private
      def self.parse(str, count)
        parser = new(str, count)
        parser.parse
      end

      def initialize(str, count)
        @scanner = StringScanner.new(str)
        @count = count
        @value = []
      end

      def parse
        while !@scanner.eos?
          parse_noun || parse_verb ||
          parse_count || parse_char
        end

        @value.join
      end

      private

      # @api private
      def parse_noun
        if @scanner.scan(/\{\{N([^\}]*?):([^\}]+?)\}\}/)
          option = @scanner[1].to_s.tr(" ", "").downcase
          if option =~ /[^sp]/i
            raise "Unknown option '#{option}' in {{N:...}} tag"
          end
          inflection = if option.empty?
                         @count == 1 ? :singular : :plural
                       else
                         option == "s" ? :singular : :plural
                       end
          noun = Noun[@scanner[2].to_s.tr(" ", "")]
          @value << noun.public_send(inflection)
        end
      end

      # @api private
      def parse_verb
        if @scanner.scan(/\{\{V([^\}]*?):([^\}]+?)\}\}/)
          option = @scanner[1].to_s.tr(" ", "").downcase
          if !option.empty?
            raise "Unknown option '#{option}' in {{V:...}} tag"
          end
          inflection = @count == 1 ? :singular : :plural
          verb = Verb[@scanner[2].to_s.tr(" ", "")]
          @value << verb.public_send(inflection)
        end
      end

      # @api private
      def parse_count
        if @scanner.scan(/\{\{#([^\}]*?):([^\}]+?)\}\}/)
          require "strings-numeral"
          option = @scanner[1].to_s.tr(" ", "").downcase
          if option =~ /[^fwo\d]/
            raise "Unknown option '#{option}' in {{#:...}} tag"
          end
          @value << parse_count_flags(option)
        end
      end

      # @api private
      def parse_count_flags(option)
        case option
        when -> (opt) { opt =~ /w/ && opt =~ /o/ }
          Strings::Numeral.ordinalize(@count)
        when /w(\d*)/
          if $1.empty? || @count <= $1.to_i
            Strings::Numeral.cardinalize(@count)
          else
            @count
          end
        when "o"
          Strings::Numeral.ordinalize(@count, short: true)
        when "f"
          fuzzy_count(@count)
        else
          @count
        end
      end

      # @api private
      def parse_char
        @value << @scanner.getch
      end

      # @api private
      def fuzzy_count(count)
        if count >= 10 then "many"
        elsif count >= 6 then "several"
        elsif count >= 3 then "a few"
        elsif count == 2 then "a couple of"
        elsif count == 1 then "one"
        else "no"
        end
      end
    end # Parser
  end # Inflection
end # Strings
