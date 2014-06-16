require "opening_hours/version"
require "ostruct"

module OpeningHours
  class OpeningHours
    def self.parse(params)
      self.new(params)
    end

    def initialize(params)
      params = Array(params)
      check_params(params)

      params.each do |param|
        param_values = parse_param(param)
        param_values.days.each do |day|
          open_time = time_parse(param_values.times[0])
          close_time = time_parse(param_values.times[1])
          open_hours[valid_days.index(day)] << (open_time..close_time)
        end
      end
      self
    end

    def open_at?(date_time)
      dt = date_time.to_datetime
      day = dt.wday
      time = dt.strftime("%H:%M")
      time = time_parse(time)
      if open_hours[day]
        open_hours[day].any? {|x| x.cover?(time) }
      else
        false
      end
    end

    private

    def check_params(params)
      params.each do |param|
        day_and_time = param.split(' ')
        raise ArgumentError unless day_and_time.count == 2

        day_range = day_and_time[0]
        time_range = day_and_time[1]

        days = day_range.split('-')

        raise ArgumentError unless (1..2).cover?(days.count)

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

    def parse_param(param)
      day_and_time = param.split(' ')
      day_range = day_and_time[0]
      time_range = day_and_time[1]

      days = day_range.split('-')

      if day_range.include?('-') && days.count == 2
        start_day = valid_days.index(days[0])
        end_day = valid_days.index(days[1])
        days = valid_days[start_day..end_day]
      end

      days.each do |day|
        unless open_hours[valid_days.index(day)]
          open_hours[valid_days.index(day)] = []
        end
      end

      times = time_range.split('-')
      x = OpenStruct.new
      x.times = times
      x.days = days
      x
    end


    def open_hours
      @open_hours ||= {}
    end

    def time_parse(t)
      t = Time.parse(t)
      (t.hour * 60) + t.min
    end

    def valid_days
      %w(Su Mo Tu We Th Fr Sa)
    end
  end
end
