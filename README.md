# Arpabet

This gem provides a method of getting an IPA transcription for [ARPABET](https://en.wikipedia.org/wiki/ARPABET) phonemes. The reason this gem was born - to prepare CMUDict with transcriptions instead of phonemes set, so than only English phonemes supported at the moment.

It splits input phonemes into syllables and when there is a stressed vowel inside it places stress before the syllable. Syllabification is based on "A Rule Based Algorithm for Automatic Syllabification of a Word of Bodo".

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arpabet'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arpabet

## Usage

```ruby
require 'arpabet'
Arpabet.transcription(%w(AE2 B ER0 K R AA1 M B IY0))
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/[USERNAME]/arpabet>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Arpabet project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/arpabet/blob/master/CODE_OF_CONDUCT.md).
