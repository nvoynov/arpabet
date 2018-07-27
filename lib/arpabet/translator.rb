# encoding: UTF-8

require_relative 'syllabifier'

module Arpabet

  module Translator
    extend self

    # @param phonemes [Array<String>] array of 2-letters arpabet phonemes
    # @return [Array<String>] array of Bodo phonemes ('V' or 'C')
    def phonemes_to_bodo(phonemes)
      phonemes.inject([]){|bodo, phn|
        bodo << ((VOVELS[phn] || VOVELS[phn[0..-2]]) ? 'V' : CONSONANTS[phn] ? 'C' : '?')
      }
    end

    # @param phonemes [Array<String>] array of Bodo phonemes ('V' or 'C')
    # @return [Array<Array<String>>] array of syllables
    # def syllabify(phonemes)
    # end

    # @param phonemes [Array<String>] array of 2-letters arpabet phonemes
    # @return [String] IPA presentation of phonemes
    def phonemes_to_ipa(phonemes)
      syllables = Syllabifier.(phonemes_to_bodo(phonemes))
    end

    VOVELS = {
      'AA' => 'ɑ',
      'AE' => 'æ',
      'AH' => 'ʌ',
      # nvoynov added
      "AH1"=>"ʌ",
      "AH0"=>"ə",
      "AX0"=>"ə",
      # >> end of nvoynov added
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
      # 'HH or H[4]' => 'h',
      'HH' => 'h',
      'H' => 'h',
      'JH' => 'dʒ',
      'K' => 'k',
      'L' => 'l',
      'M' => 'm',
      'N' => 'n',
      # 'NX or NG[4]' => 'ŋ',
      # 'NX[4]' => 'ɾ̃',
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

require 'pp'
include Arpabet

pp Translator.phonemes_to_bodo(%w(AH0 B AE1 K))
pp Translator.phonemes_to_ipa(%w(AH0 B AE1 K))
# pp Arpabet.transcription %w(AE1 B AH0 K OW2)
# pp Arpabet.transcription %w(AE1 B AH0 K AH0 S))
