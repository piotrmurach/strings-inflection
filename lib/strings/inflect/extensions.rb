# frozen_string_literal: true

module Strings
  module Inflect
    module Extensions
      refine String do
        def inflect(*args, **options)
          Strings::Inflect.inflect(self, *args, **options)
        end

        def singularize(**options)
          Strings::Inflect.singularize(self, **options)
        end

        def pluralize(**options)
          Strings::Inflect.pluralize(self, **options)
        end

        def singular?(**options)
          Strings::Inflect.singular?(self, **options)
        end

        def plural?(**options)
          Strings::Inflect.plural?(self, **options)
        end

        def join_words(*words, **options)
          Strings::Inflect.join_words(self, *words, **options)
        end
      end
    end # Extensions
  end # Inflect
end # Strings
