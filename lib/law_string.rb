# frozen_string_literal: true

require 'digest/md5'
require 'set'

# Specialized #titleize and #add_typography methods.
class String
  # For AP Style Titles
  # A decent article: https://prowritingaid.com/list-of-words-not-capitalized-in-titles
  NOT_CAPITALIZED = Set.new %w[
    a
    an
    and
    as
    at
    but
    by
    down
    for
    from
    if
    in
    into
    near
    nor 
    of
    on
    onto
    or
    over
    out 
    so 
    than
    that
    the
    to
    up
    with 
    yet
  ].freeze

  INITIALISMS = Set.new %w[atm usa].freeze

  INITIALS_REGEX  = /^([a-zA-Z]\.)+$/.freeze
  WHITESPACES_REGEX = /[[:space:]]/.freeze

  def in?(an_array)
    an_array.include?(self)
  end

  def initials?
    INITIALS_REGEX.match?(self)
  end

  def initialism?
    INITIALISMS.include?(self)
  end

  def starts_with?(str)
    start_with?(str)
  end

  def md5_sum
    Digest::MD5.hexdigest(self)
  end

  #
  # A better titleize that creates a usable title according to English grammar
  # rules. It's coded to reduce object allocation.
  #
  def titleize
    new_string = clone(freeze: false)

    new_string.tr!('_', ' ')
    final_string = new_string.split(WHITESPACES_REGEX)
                             .map { |w| titleize_word(w) }
                             .join(' ')
    final_string.capitalize_first_letter!
    final_string
  end

  def titleize_word(word)
    if word.start_with?('"', '(', '[', '{')
      extra = word[0]
      word  = word.tail
    else
      extra = ''
    end

    word.downcase!
    if NOT_CAPITALIZED.include?(word)
      # Do nothing
    elsif word.initials? || word.initialism?
      word.upcase!
    else
      word.capitalize!
    end

    if extra == ''
      word
    else
      extra + word
    end
  end

  def tail
    self[1..-1]
  end

  #
  # Replace my value with the titleized version.
  #
  def titleize!
    replace titleize
  end

  #
  # Return a new string enhanced with UTF-8 typographic characters:
  #  Single quotes: ’
  #  Section sign:  §
  #  Double quotes: “”
  #
  def add_typography
    tr("'", '’')
      .gsub(/\bSec\./, '§')
      .gsub(/"([^"]+)"/, '“\1”')
  end

  def add_html_typography
    gsub(%r{\b(\d+)/(\d+)\b}, '<sup>\1</sup>&frasl;<sub>\2</sub>')
  end

  #
  # Take text with potential encoding problems and
  # aggressively make it safe for UTF-8 import.
  #
  def utf8_safe
    encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
  end

  def capitalize_first_letter
    return '' if self == ''

    new_string = clone(freeze: false)
    new_string.capitalize_first_letter!
    new_string
  end

  def capitalize_first_letter!
    return self if self == ''

    self[0] = self[0].upcase
  end
end
