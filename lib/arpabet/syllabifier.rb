# encoding: UTF-8

module Arpabet

  module Syllabifier
    extend self

    # @param phonemes [Array<BodoPhonemes>] like %w(V C C V C V C C V)
    def syllabify(phonemes)
      bodo = phonemes.dup
      bodo = bodo.chars if bodo.is_a? String
      validate!(bodo)
      [].tap do |out|
        while !bodo.empty?
          syll = ''
          if only_one_vowel?(bodo) || bodo.join == 'CVV'
            syll, bodo = bodo.join, []
          else
            rule = find_rule(bodo)
            break unless rule # something impossible?
            syll, _ = rule.split('/')
            bodo.shift(syll.size)
          end
          out << '/' unless out.empty?
          out.concat(syll.chars)
        end
      end
    end

    alias_method :call, :syllabify

    RULES = {
      'VV' => 'V/V',
      'VCCV' => 'VC/CV',
      'VCCCV' => 'VC/CCV',
      'CVVCV' => 'CVV/CV',
      'CVVC' => 'CV/VC',
      'VCVC' => 'V/CVC',
      'VCVV' => 'V/CVV',
      'VCV' => 'V/CV',
      'CVCVV' => 'CV/CVV',
      'CVCVC' => 'CV/CVC',
      'CVCCV' => 'CVC/CV'
    }.freeze

    protected

    def validate!(phonemes)
      raise ArgumentError, "Only phonemes 'V' and 'C' are allowed" if phonemes.join.match?(/[^CV]/)
    end

    def only_one_vowel?(phonemes)
      phonemes.select{|i| i == 'V'}.size == 1
    end

    def find_rule(phonemes)
      RULES.each do |pattern, rule|
        return rule if phonemes.join.match(/^#{pattern}/)
      end
      nil
    end

  end

end

# require 'pp'
# require 'minitest/autorun'
# include Arpabet
#
# describe Syllabifier do
#
#   describe '#sylabify' do
#     it 'must split patterns at first :)' do
#       Syllabifier::RULES.each do |pattern, rule|
#         Syllabifier.(pattern).join.must_equal rule
#       end
#     end
#   end
#
# end
