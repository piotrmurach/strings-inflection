# frozen_string_literal: true

require "strscan"

require_relative "noun"

module Strings
  module Inflect
    class Parser
      # Parse a string by evaluating content inside tags
      #
      # @api private
      def self.parse(str, count)
        scanner = StringScanner.new(str)
        value = []

        while !scanner.eos?
          parse_noun(scanner, count, value) ||
          parse_verb(scanner, count, value) ||
          parse_count(scanner, count, value) ||
          parse_char(scanner, count, value)
        end

        value.join
      end

      # @api private
      def self.parse_noun(scanner, count, value)
        if scanner.scan(/\{\{N([^\}]*?):([^\}]+?)\}\}/)
          option = scanner[1].to_s.tr(" ", "").downcase
          if option =~ /[^sp]/i
            raise "Unknown option '#{option}' in {{N:...}} tag"
          end
          inflection = if option.empty?
                         count == 1 ? :singular : :plural
                       else
                         option == "s" ? :singular : :plural
                       end
          noun = Noun[scanner[2].to_s.tr(" ", "")]
          value << noun.public_send(inflection)
        end
      end

      # @api private
      def self.parse_verb(scanner, count, value)
        if scanner.scan(/\{\{V([^\}]*?):([^\}]+?)\}\}/)
          option = scanner[1].to_s.tr(" ", "").downcase
          if !option.empty?
            raise "Unknown option '#{option}' in {{V:...}} tag"
          end
          inflection = count == 1 ? :singular : :plural
          verb = Verb[scanner[2].to_s.tr(" ", "")]
          value << verb.public_send(inflection)
        end
      end

      # @api private
      def self.parse_count(scanner, count, value)
        if scanner.scan(/\{\{#([^\}]*?):([^\}]+?)\}\}/)
          option = scanner[1].to_s.tr(" ", "").downcase
          if option =~ /[^f]/
            raise "Unknown option '#{option}' in {{#:...}} tag"
          end
          amount = case option
                   when "f"
                     fuzzy_count(count)
                   else
                     count
                   end
          value << amount
        end
      end

      # @api private
      def self.parse_char(scanner, count, value)
        value << scanner.getch
      end

      # @api private
      def self.fuzzy_count(count)
        if count >= 10 then "many"
        elsif count >= 6 then "several"
        elsif count >= 3 then "a few"
        elsif count == 2 then "a couple of"
        elsif count == 1 then "one"
        else "no"
        end
      end
    end # Parser
  end # Inflect
end # Strings
