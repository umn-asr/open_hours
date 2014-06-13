# OpeningHours

Library that parses date ranges in the openingHours format https://schema.org/openingHours.

## Installation

Add this line to your application's Gemfile:

    gem 'opening_hours'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install opening_hours

## Usage

```ruby
raw = ["Mo-Th 08:00-16:30", "Fr 08:00-16:00"]
op = OpeningHours.parse(raw)

op.class #=> OpeningHours

time = DateTime.parse("Monday, June 14 08:00")
op.open_at?(time) #=> true

time = DateTime.parse("Monday, June 14 07:59")
op.open_at?(time) #=> false

time = DateTime.parse("Monday, June 14 16:30")
op.open_at?(time) #=> true

time = DateTime.parse("Monday, June 14 16:31")
op.open_at?(time) #=> false

time = DateTime.parse("Saturday, June 19 08:30")
op.open_at?(time) #=> false
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/opening_hours/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
