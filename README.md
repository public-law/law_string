# LawString

[![Build Status](https://travis-ci.org/public-law/law_string.svg?branch=master)](https://travis-ci.org/public-law/law_string)

A few string util functions which support the [Public.Law](https://www.public.law) apps. Optimized for reduced object instantiation
at the expense of readability.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'law_string'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install law_string

## Usage

Provides;

* `#add_typograpy` e.g., changing ASCII quotes to true double quotes
* `#titleize` enhanced for English-language legal texts
* `#initials` to detect, e.g., "A.S.C.A.P."

See the tests for details.
