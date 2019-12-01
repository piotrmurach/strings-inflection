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
        [/(.*go|do)$/, "\\1es"],
        [/(.*demo)$/, "\\1s"],
        [/\A(gas)$/i, "\\1ses"],
        [/(.*precis)$/i, "\\1es"],
        [/(.*stomach)$/i, "\\1s"],
      ]

      @singular_rules = [
        [/(.*[y]ch)$/i, "\\1s"],
        [/(.*[cs]h)$/i, "\\1es"],
        [/(.*is)$/i, "\\1ses"],
        [/(.*[ua]s)$/i, "\\1es"],
        [/(.*[x])$/i, "\\1es"],
        [/(.*oe)$/i, "\\1s"],
        [/(.*iz)$/i, "\\1zes"],
        [/(.*zz)$/i, "\\1es"],
        [/(.*[il]tz)$/i, "\\1es"],
        [/(.*ss)$/i, "\\1es"],
        [/(.*[aeiou])y$/i, "\\1ys"],
        [/(.*)y$/i, "\\1ies"],
        [/(.*[io]o)$/i, "\\1s"],
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
        [/(.*go|do)es$/, "\\1"],
        [/\A(bellyache|ache)s$/, "\\1"],
        [/\A(axe)s$/, "\\1"],
        [/\A(bus)es$/, "\\1"],
        [/(.*caucus)es$/i, "\\1"],
        [/(.*finesse)s$/i, "\\1"],
        [/(.*bias)es$/i, "\\1"],
        [/(.*cache)s$/i, "\\1"],
        [/(.*caddie)s$/i, "\\1"],
        [/(.*caucus)es$/i, "\\1"],
        [/(.*chorus)es$/i, "\\1"],
        [/\A(die|hie|vie)s$/i, "\\1"],
        [/\A(lie|belie|overlie|underlie)s$/i, "\\1"],
        [/\A(tie|untie)s$/i, "\\1"],
        [/\A(dis|gas)ses$/i, "\\1"],
        [/(.*echo|veto)es$/i, "\\1"],
        [/(.*douche)s$/i, "\\1"],
        [/(.*focus)es$/i, "\\1"],
        [/(.*precis)es$/i, "\\1"],
        [/(.*quiz)zes$/i, "\\1"],
        [/(.*stymie)s$/i, "\\1"],
        [/(.*sk)ies$/i, "\\1y"],
        [/(.*whiz)zes$/i, "\\1"]
      ]

      @plural_rules = [
        [/(.*[aeiou]y)s$/i, "\\1"],
        [/(.*[aiurywnopl]se)s$/i, "\\1"],
        [/(.*[cs]h)es$/i, "\\1"],
        [/(.*[sx])es$/i, "\\1"],
        # [/(.*oe)s$/i, "\\1"],
        [/(.*zz)es$/i, "\\1"],
        [/(.*[il]tz)es$/i, "\\1"],
        [/(.*ue)s$/i, "\\1"],
        [/(.*[gk]ie)s$/i, "\\1"],
        [/(.*all)ies$/i, "\\1y"],
        [/(.*)ies$/i, "\\1y"],
        [/(.*y)s$/i, "\\1"],
        [/(.*[thn]oe)s$/i, "\\1"],
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
