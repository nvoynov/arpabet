require "arpabet/version"
require "arpabet/translator"
require "arpabet/syllabifier"

module Arpabet
  extend self

  # @param phonemes [Array<String>] array of 2-letters arpabet phonemes
  # @return [String] IPA transcription
  def transcription(phonemes)
    Translator.(phonemes)
  end

end
