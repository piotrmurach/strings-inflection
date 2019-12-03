# frozen_string_literal: true

module Strings
  module Inflection
    module Extensions
      refine String do
        def inflect(*args, **options)
          Strings::Inflection.inflect(self, *args, **options)
        end

        def singularize(**options)
          Strings::Inflection.singularize(self, **options)
        end

        def pluralize(**options)
          Strings::Inflection.pluralize(self, **options)
        end

        def singular?(**options)
          Strings::Inflection.singular?(self, **options)
        end

        def plural?(**options)
          Strings::Inflection.plural?(self, **options)
        end

        def join_words(*words, **options)
          Strings::Inflection.join_words(self, *words, **options)
        end
      end
    end # Extensions
  end # Inflection
end # Strings
