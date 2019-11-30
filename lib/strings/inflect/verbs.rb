# frozen_string_litearl: true

module Strings
  module Inflect
    module Verbs

      @uninflected = [
        "can",
        "may",
        "must",
        "ought",
        "shall",
        "will"
      ]

      @singular_irregular = [
        [/\Aare$/, "is"],
        [/\Awere$/, "was"],
        [/\A(ha)ve$/, "\\1s"],
      ]

      @singular_rules = [
        [/(.*[cs]h)$/i, "\\1es"],
        [/(.*[x])$/i, "\\1es"],
        [/(.*oe)$/i, "\\1s"],
        [/(.*zz)$/i, "\\1es"],
        [/(.*ss)$/i, "\\1es"],
        [/(.*[aeiou])y$/i, "\\1ys"],
        [/(.*)y$/i, "\\1ies"],
        [/(.*o)$/i, "\\1es"],
        [/(.*[^s])$/i, "\\1s"],
        [/(.*)s$/i, "\\1s"],
        [/(.*)$/i, "\\1s"]
      ]

      @singulars = @singular_irregular + @singular_rules

      @plural_irregular = [
        [/\A(am|is)$/, "are"],
        [/\Awas$/, "were"],
        [/\Ahas$/, "have"],
        [/\A(go|do)es$/, "\\1"]
      ]

      @plural_rules = [
        [/(.*[aeiou]y)s$/i, "\\1"],
        [/(.*[cs]h)es$/i, "\\1"],
        [/(.*[sx])es$/i, "\\1"],
        [/(.*oe)s$/i, "\\1"],
        [/(.*zz)es$/i, "\\1"],
        [/(.*)ies$/i, "\\1y"],
        [/(.*o)es$/i, "\\1"],
        [/(.+[^s])s$/i, "\\1"],
        [/(.+)s$/i, "\\1"]
      ]

      @plurals = @plural_irregular + @plural_rules

      # A set of uninflected verbs
      #
      # @return [Array[String]]
      #
      # @api private
      def uninflected
        @uninflected
      end
      module_function :uninflected

      # A list of singular rules
      #
      # @return [Array[String]]
      #
      # @api private
      def singulars
        @singulars
      end
      module_function :singulars

      # A list of plural rules
      #
      # @return [Array[String]]
      #
      # @api private
      def plurals
        @plurals
      end
      module_function :plurals
    end # Verbs
  end # Inflect
end # Strings
