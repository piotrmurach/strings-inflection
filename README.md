<div align="center">
  <img width="225" src="https://github.com/piotrmurach/strings/blob/master/assets/strings_logo.png" alt="strings logo" />
</div>

# Strings::Inflect

[![Gem Version](https://badge.fury.io/rb/strings-inflect.svg)][gem]
[![Build Status](https://secure.travis-ci.org/piotrmurach/strings-inflect.svg?branch=master)][travis]
[![Build status](https://ci.appveyor.com/api/projects/status/v8beeg5pmsdncvu8?svg=true)][appveyor]
[![Maintainability](https://api.codeclimate.com/v1/badges/4951f64ee240909fbde1/maintainability)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/github/piotrmurach/strings-inflect/badge.svg?branch=master)][coverage]
[![Inline docs](http://inch-ci.org/github/piotrmurach/strings-inflect.svg?branch=master)][inchpages]

[gem]: http://badge.fury.io/rb/strings-inflect
[travis]: http://travis-ci.org/piotrmurach/strings-inflect
[appveyor]: https://ci.appveyor.com/project/piotrmurach/strings-inflect
[codeclimate]: https://codeclimate.com/github/piotrmurach/strings-inflect/maintainability
[coverage]: https://coveralls.io/github/piotrmurach/strings-inflect?branch=master
[inchpages]: http://inch-ci.org/github/piotrmurach/strings-inflect

> Inflects English nouns and verbs.

**Strings::Inflect** provides English inflections of nouns and verbs component for [Strings](https://github.com/piotrmurach/strings).

## Motivation

The goal is to provide a comprehensive inflections for most nouns and verbs. The algorithms that this gem uses are based on the analysis of 6,500 most frequently used nouns and around 6,000 most used verbs in English language. Because of this you will get correct inflections for most words:

```ruby
Strings::Inflect.pluralize("cod") # => "cod"
Strings::Inflect.pluralize("codex") # => "codices"
Strings::Inflect.pluralize("criterion") # => "criteria"
Strings::Inflect.pluralize("vertebra") # => "vertebrae"
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'strings-inflect'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install strings-inflect

## Contents

* [1. Usage](#1-usage)
* [2. API](#2-api)
  * [2.1 inflect](#21-inflect)
    * [2.1.1 template](#211-template)
  * [2.2 singularize](#22-singularize)
  * [2.3 singular?](#23-singular)
  * [2.4 pluralize](#24-pluralize)
  * [2.5 plural?](#25-plural)
  * [2.6 join_words](#26-join-words)
  * [2.7 configure](#27-configure)
* [3. Extending String class](#3-extending-string-class)

## 1. Usage

**Strings::Inflect** provides a generic `inflect` method for transforming noun or verb inflections. In the most common case, it assumes that you wish to transform a noun to another form based on count:

```ruby
Strings::Inflect.inflect("error", 3)
# => "errors"
```

As a shortcut, when you wish to always convert a word to singular form use `singularize` or `pluralize` for the opposite:

```ruby
Strings::Inflect.singularize("errors") # => "error"
Strings::Inflect.pluralize("error") # => "errors"
Strings::Inflect.singularize("try", term: :verb) # => "tries"
Strings::Inflect.pluralize("tries", term: :verb) # => "try"
```

Alternatively, you can convert words into a noun or verb object. This way you gain access to `singular`and `plural` methods:

```ruby
Strings::Inflect::Noun("errors").singular # => "error"
Strings::Inflect::Noun("error").plural # => "errors"
Strings::Inflect::Verb("try").singular # => "tries"
Strings::Inflect::Verb("tries").plural # => "try"
```

The `inflect` method also accepts a mustache-like template to inflect more complex phrases and sentences:

```ruby
Strings::Inflect.inflect("{{#:count}} {{N:error}} {{V:was}} found", 3)
# => "3 errors were found"
```

To change any inflection rules, you can change them using `configure`:

```ruby
Strings::Inflect.configure do |config|
  config.plural "index", "indexes"
  config.singular "axes", "ax"
end
```

## 2. API

### 2.1 inflect

In the most common case, to change a noun's inflection use `inflect` method with the word and a count. By default `inflect` assumes a noun.

For example, to inflect the noun `error` to its plural form do:

```ruby
Strings::Inflect.inflect("error", 2) # => "errors"
```

And to inflect a verb, use the `:term` option:

```ruby
Strings::Inflect.inflect("tries", 2, term: :verb) # => "try"
```

For more complex cases when you want to inflect parts of a sentence, the `inflect` provides tags in a template.

For example, you can inflect a noun and a verb to display information based on the count:

```ruby
Strings::Inflect.inflect("{{#:count}} {{N:error}} {{V:was}} found", 2)
# => "2 errors were found"
```

#### 2.1.1 template

The template inflects any content inside mustache-like braces `{{...}}`. The general form of content inside tag is `{{Xmod:word}}` where:

* `X` informs a grammatical function to apply to word out of `N` or `V` and `#`.
* `mod` apply zero or more modifiers to word transformation.
* `word` represents the string to inflect.

The available tags are:

`{{#: count }}`

The first type of tag is the count tag. By default, this tag will display the count inside the evaluated string.

```ruby
String::Inflect.inflect("{{#:count}} found", 2)
# => "2 found"
```

There is an `f` option that will provide a fuzzy estimation of the count:

```ruby
String::Inflect.inflect("{{#f:count}}", 0) # => "no"
String::Inflect.inflect("{{#f:count}}", 1) # => "one"
String::Inflect.inflect("{{#f:count}}", 2) # => "a couple of"
String::Inflect.inflect("{{#f:count}}", 3) # => "a few"
String::Inflect.inflect("{{#f:count}}", 6) # => "several"
String::Inflect.inflect("{{#f:count}}", 12) # => "many"
```

`{{N: word }}`

This tag inflects a noun into a singular or plural form based on the provided count.

```ruby
Strings::Inflect.inflect("{{#:count}} {{N:error}} found", 3)
# => "3 errors found"
```

You can supply `s` or `p` options to always force a noun to be singular or plural form.

```ruby
Strings::Inflect.inflect("{{#:count}} {{Ns:error}} found", 3)
# => "3 error found"
```

`{{V: word }}`

This tag inflects a verb into appropriate form based on the provided count.

```ruby
Strings::Inflect.inflect("There {{V:were}} {{#:count}} {{N:match}} found", 1)
# => "There was 1 match found"
```

### 2.2 singularize

You can transform a noun or a verb into singular form with `singularize` method. By default it assumes a noun but you can change this with `:term` option:

```ruby
Strings::Inflect.singularize("errors") # => "error"
Strings::Inflect.singularize("indices") # => "index"
Strings::Inflect.singularize("index", term: :verb) # => "indexes"
Strings::Inflect.singularize("try", term: :verb) # => "tries"
```

It will handle inflecting irregular nouns or verbs as well:

```ruby
Strings::Inflect.singularize("feet") # => "foot"
Strings::Inflect.singularize("are", term: :verb) # => "is"
Strings::Inflect.singularize("go", term: :verb) # => "goes"
```

This method won't change inflection if it already is in the correct form:

```ruby
Strings::Inflect.singularize("index") # => "index"
Strings::Inflect.singularize("sees") # => "sees"
```

### 2.3 singular?

To check if a noun or a verb is in a singular form use `singular?`:

```ruby
Strings::Inflect.singular?("errors") # => false
Strings::Inflect.singular?("index") # => true
Strings::Inflect.singular?("try", term: :verb) # => false
Strings::Inflect.singular?("goes", term: :verb) # => true
```

You can also convert a word to a noun or verb object:

```ruby
Strings::Inflect::Noun("errors").singular? # => false
Strings::Inflect::Noun("index").singular? # => true
Strings::Inflect::Verb("try").singular? # => false
Strings::Inflect::Verb("goes").singular? # => true
```

### 2.4 pluralize

### 2.5 plural?

To check if a noun or a verb is in a plural form use `plural?`:

```ruby
Strings::Inflect.plural?("errors") # => true
Strings::Inflect.plural?("index") # => false
Strings::Inflect.plural?("try", term: :verb) # => true
Strings::Inflect.plural?("goes", term: :verb) # => false
```

You can also convert a word to a noun or verb object:

```ruby
Strings::Inflect::Noun("errors").plural? # => true
Strings::Inflect::Noun("index").plural? # => false
Strings::Inflect::Verb("try").plural? # => true
Strings::Inflect::Verb("goes").plural? # => false
```

### 2.6 join_words

To join an array of words into a single sentence use `join_words` method.

For example, to join three words:

```ruby
Strings::Inflect.join_words("one", "two", "three")
# => "one, two, and three"
```

To join words without Oxford style comma use `:final_separator`:

```ruby
Strings::Inflect.join_words("one", "two", "three", final_separator: "")
# => "one, two and three"
```

To join words with custom separators:

```ruby
options = {
  separator: " or ",
  final_separator: " or at least ",
  conjunctive: ""
}
Strings::Inflect.join_words("one", "two", "three", **options)
# => "one or two or at least three"
```

### 2.7 configure

```ruby
Strings::Inflect.configure do |config|

end
```

## 3. Extending String class

Though it is highly discouraged to pollute core Ruby classes, you can add the required methods to `String` class by using refinements.

For example, if you wish to only extend strings with `inflect` method do:

```ruby
module MyStringExt
  refine String do
    def inflect(*args, **options)
      Strings::Inflect.inflect(self, *args, **options)
    end
  end
end
```

Then `inflect` method will be available for any strings where refinement is applied:

```ruby
using MyStringExt

"error".inflect(2) # => "errors"
"are".inflect(1, term: :verb) # => "is"
```

However, if you want to include all the **Strings::Inflect** methods, you can use provided extensions file:

```ruby
require "strings/inflect/extensions"

using Strings::Inflect::Extensions
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/piotrmurach/strings-inflect. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Strings::Inflect project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/strings-inflect/blob/master/CODE_OF_CONDUCT.md).


## Copyright

Copyright (c) 2019 Piotr Murach. See LICENSE for further details.
