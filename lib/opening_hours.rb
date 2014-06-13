require "opening_hours/version"

module OpeningHours
  class OpeningHours
    def self.parse(params)
      self.new(params)
    end

    def initialize(params)
      params = Array(params)

      params.each do |param|
        day_and_time = param.split(' ')
        raise ArgumentError unless day_and_time.count == 2

        day_range = day_and_time[0]
        time_range = day_and_time[1]

        days = day_range.split('-')

        raise ArgumentError unless (1..2).cover?(days.count)

        valid_days = %w(Mo Tu We Th Fr Sa Su)
        days.each do |day|
          raise ArgumentError unless valid_days.include?(day)
        end

        times = time_range.split('-')

        raise ArgumentError unless times.count == 2

        times.each do |time|
          raise ArgumentError unless time.match(/\d\d:\d\d/)
        end
      end
    end
  end
end
