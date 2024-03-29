# rubocop:disable Metrics/BlockLength, Style/FrozenStringLiteralComment

require 'spec_helper'
require 'law_string'

RSpec.describe String do
  it { should be_an_instance_of(String) }

  describe '#in?' do
    it 'gives same positive result as include?' do
      array  = [1, 2, 3, 4, 5]
      string = 'I am 4 years old'
      expect(string.in?(array)).to eq(array.include?(string))
    end
  end

  describe '#add_typography' do
    it 'leaves a boring string alone' do
      expect('snurk'.add_typography).to eq 'snurk'
    end

    it 'converts a fake single quote to a proper quote' do
      expect("Workers'".add_typography).to eq 'Workers’'
    end

    it 'converts two fake double quotes correctly' do
      expect('"Car"'.add_typography).to eq '“Car”'
    end

    it 'converts a section abbreviation to the symbol' do
      expect('Sec. 123'.add_typography).to eq '§ 123'
    end
  end

  describe '#capitalize_first_letter' do
    it 'handles an all-lowercase word' do
      expect('apple'.capitalize_first_letter).to eq 'Apple'
    end

    it 'leaves an all-uppercase word unchanged' do
      expect('APPLE'.capitalize_first_letter).to eq 'APPLE'
    end

    it 'handles empty string' do
      expect(''.capitalize_first_letter).to eq ''
    end
  end

  describe '#starts_with?' do
    it 'answers queries about the first letter' do
      expect('Mellow'.starts_with?('M')).to be true
      expect('Mellow'.starts_with?('x')).to be false
    end
  end

  describe '#titleize' do
    it 'knows about some initialisms' do
      input    = 'ATM TRANSACTIONS BY PERSONS USING USA BANK ACCOUNTS'
      expected = 'ATM Transactions by Persons Using USA Bank Accounts'
      expect(input.titleize).to eq expected
    end

    it 'handles "with"' do
      expect('The dog with a bone'.titleize).to eq 'The Dog with a Bone'
    end

    it 'does capitalize short verbs' do
      expect('The dog is home'.titleize).to eq 'The Dog Is Home'
    end

    it 'converts underscore to space' do
      expect('red_bearings'.titleize).to eq 'Red Bearings'
    end

    it "handles Unicode NBSP's" do
      expect('Fishery management'.titleize).to eq 'Fishery Management' # space
      expect('Fishery management'.titleize).to eq 'Fishery Management' # nbsp
    end

    it 'returns a new instance' do
      a = 'apple'
      expect(a.titleize).not_to be a
    end

    it 'handles initials properly' do
      expect('n.y.'.titleize).to eq 'N.Y.'
    end

    it 'handles initials in a larger string' do
      expect('n.y. state lottery'.titleize).to eq 'N.Y. State Lottery'
    end

    it 'handles phrases with double quotes' do
      input  = "LOANS PURSUANT TO THE \"SERVICEMEN'S READJUSTMENT ACT OF 1944\""
      output = 'Loans Pursuant to the "Servicemen\'s Readjustment Act of 1944"'
      expect(input.titleize).to eq output
    end

    it 'handles words in parentheses' do
      expect('(SOMETHING INTERESTING)'.titleize).to eq '(Something Interesting)'
    end
  end

  describe '#initials?' do
    it 'recognizes a state' do
      expect('n.y.'.initials?).to be true
    end

    it 'recognizes upper case' do
      expect('A.S.C.A.P.'.initials?).to be true
    end
  end

  describe '#titleize!' do
    it "changes the string's value" do
      a = 'apple'
      a.titleize!
      expect(a).to eq 'Apple'
    end

    it 'returns the original instance' do
      a = 'apple'
      expect(a.titleize!).to be a
    end
  end

  describe '#md5_sum' do
    it 'returns a valid-looking hash' do
      expect('snack time is best time'.md5_sum).to match(/^[a-f0-9]{32}$/)
    end
  end

  describe '#add_typography' do
    it 'converts single quotes' do
      expect("dog's life".add_typography).to eq 'dog’s life'
    end

    it 'converts to the section symbol' do
      expect('Sec. 206'.add_typography).to eq '§ 206'
    end

    it 'converts double quotes' do
      expect('"Hey!"'.add_typography).to eq '“Hey!”'
    end
  end

  describe '#add_html_typography' do
    it 'creates simple fractions' do
      plaintext = 'on 1/2 of an egg'
      expected  = 'on <sup>1</sup>&frasl;<sub>2</sub> of an egg'
      expect(plaintext.add_html_typography).to eq expected
    end
  end
end

# rubocop:enable  Metrics/BlockLength, Style/FrozenStringLiteralComment
