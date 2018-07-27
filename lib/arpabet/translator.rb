# encoding: UTF-8

require_relative 'syllabifier'

module Arpabet

  module Translator
    extend self

    # @param phonemes [Array<String>] array of 2-letters arpabet phonemes
    # @return [Array<String>] array of Bodo phonemes ('V' or 'C')
    def phonemes_to_bodo(phonemes)
      phonemes.inject([]){|bodo, phone|
        ph, _ = phone.match(/([A-Z]{1,2})([\S]*)?/).captures
        bodo << (VOVELS[ph] ? 'V' : CONSONANTS[ph] ? 'C' : '?')
        # bodo << ((VOVELS[phn] || VOVELS[phn[0..-2]]) ? 'V' : CONSONANTS[phn] ? 'C' : '?')
      }
    end

    # @param phonemes [Array<String>] array of 2-letters arpabet phonemes
    # @return [String] IPA presentation of phonemes
    def phonemes_to_ipa(phonemes)
      source = Array.new(phonemes)
      bodo = phonemes_to_bodo(source)
      syll = Syllabifier.(bodo).join.split('/').inject([]){|out, i| out << i.chars}
      tran = []
      syll.each{|s| tran << syllable_to_ipa(source.shift(s.size))}
      tran.join
    end

    alias_method :call, :phonemes_to_ipa


    def syllable_to_ipa(phonemes)
      out = []
      phonemes.each do |phn|
        ph, ax = phn.match(/([A-Z]{1,2})([\S]*)?/).captures
        out.unshift(AUXILIARY[ax]) if ax == '1' || ax == '2'
        out << (phn.eql?('AH0') ? 'ə' : PHONEMES[ph])
      end
      out.join
    end

    VOVELS = {
      'AA' => 'ɑ',
      'AE' => 'æ',
      'AH' => 'ʌ',
      'AH0'=> 'ə', # manually handled
      'AO' => 'ɔ',
      'AW' => 'aʊ',
      'AX' => 'ə',
      'AXR' => 'ɚ',
      'AY' => 'aɪ',
      'EH' => 'ɛ',
      'ER' => 'ɝ',
      'EY' => 'eɪ',
      'IH' => 'ɪ',
      'IX' => 'ɨ',
      'IY' => 'i',
      'OW' => 'oʊ',
      'OY' => 'ɔɪ',
      'UH' => 'ʊ',
      'UW' => 'u',
      'UX' => 'ʉ'
    }.freeze

    CONSONANTS = {
      'B' => 'b',
      'CH' => 'tʃ',
      'D' => 'd',
      'DH' => 'ð',
      'DX' => 'ɾ',
      'EL' => 'l̩',
      'EM' => 'm̩',
      'EN' => 'n̩',
      'F' => 'f',
      'G' => 'ɡ',
      'HH' => 'h',
      'H' => 'h',
      'JH' => 'dʒ',
      'K' => 'k',
      'L' => 'l',
      'M' => 'm',
      'N' => 'n',
      'NX' => 'ŋ',
      'NG' => 'ŋ',
      'P' => 'p',
      'Q' => 'ʔ',
      'R' => 'ɹ',
      'S' => 's',
      'SH' => 'ʃ',
      'T' => 't',
      'TH' => 'θ',
      'V' => 'v',
      'W' => 'w',
      'WH' => 'ʍ',
      'Y' => 'j',
      'Z' => 'z',
      'ZH' => 'ʒ'
    }.freeze

    PHONEMES = VOVELS.merge(CONSONANTS).freeze

    AUXILIARY = {
      '0' => '', # No stress
      '1' => 'ˈ', # Primary stress
      '2' => 'ˌ', # Secondary stress
      '3' => '', # Tertiary and further stress
      '-' => '', # Silence
      '!' => '', # Non-speech segment
      '+' => '', # Morpheme boundary
      '/' => '', # Word boundary
      '#' => '', # Utterance boundary
      ':' => '', # Tone group boundary
      ':1' => '', # Falling or declining juncture
      '.'  => '', # Falling or declining juncture
      ':2' => '', # Rising or internal juncture
      '?'  => '', # Rising or internal juncture
      ':3' => ''  #	Fall-rise or non-terminal juncture
    }.freeze

  end

end

# require 'pp'
# include Arpabet

# ABERCROMBIE  AE2 B ER0 K R AA1 M B IY0
# ABROGATE  AE1 B R AH0 G EY2 T
# pp Translator.phonemes_to_ipa(%w(AE1 B AH0 K AH0 S))
# pp Translator.phonemes_to_ipa(%w(AA0 B AA0 T IY0 EH1 L OW0))
# pp Translator.phonemes_to_ipa(%w(AE2 B ER0 K R AA1 M B IY0))
# pp Translator.phonemes_to_ipa(%w(AE1 B R AH0 G EY2 T))
