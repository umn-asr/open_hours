# OpenHours

Library that parses date ranges in the openingHours format https://schema.org/openingHours.

The main use for this is to take a set of openingHours rules and then find out if the place is open at a specific time.

## Installation

Add this line to your application's Gemfile:

    gem 'opening_hours'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install opening_hours

## Usage

### With just one openingHours rule

```ruby
one_day = "Mo 08:00-16:30"
op = OpeningHours.parse(one_day)

op.class #=> OpeningHours::OpenHours

time = DateTime.parse("Monday, June 14 2014 08:00")
op.open_at?(time) #=> true

time = DateTime.parse("Tuesday, June 14 2014 08:00")
op.open_at?(time) #=> false
```

### With a range of openingHours rules

```ruby
multi_day = ["Mo-Th 08:00-16:30", "Fr 08:00-16:00"]
op = OpeningHours.parse(multi_day)

op.class #=> OpeningHours::OpenHours

time = DateTime.parse("Monday, June 14 2014 08:00")
op.open_at?(time) #=> true

time = DateTime.parse("Monday, June 14 2014 07:59")
op.open_at?(time) #=> false

time = DateTime.parse("Monday, June 14 2014 16:30")
op.open_at?(time) #=> true

time = DateTime.parse("Monday, June 14 2014 16:31")
op.open_at?(time) #=> false

time = DateTime.parse("Saturday, June 19 2014 08:30")
op.open_at?(time) #=> false
```

## Limitations

This gem is in early days. There are parts of the openingHours spec it doesn't handle. Such as,

- Comma-separated days (ex: "Mo,Th")
- The shorthand "Mo-Su" to define being open 24 hours a day, 7 days a week
- Hours for a specific day that override the normal hours for that day.
  - This functionality is part of [openingHoursSpecfication](http://schema.org/OpeningHoursSpecification), so may not ever be implemented in this gem.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/opening_hours/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
