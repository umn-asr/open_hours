require "rspec/core"
require_relative "../lib/opening_hours"

describe OpeningHours::OpeningHours do
  let(:good_param_examples) {[
    ["Mo-Th 08:00-16:30", "Fr 08:00-16:00"],
    "Mo-Th 08:00-16:30",
  ]}

  describe "parse" do
    describe "with good params" do
      it "returns an instance of OpeningHours" do
        good_param_examples.each do |good_params|
          it = OpeningHours::OpeningHours.parse(good_params)
          expect(it).to be_a OpeningHours::OpeningHours
        end
      end
    end

    describe "with no params" do
      it "raises an ArgumentError" do
        expect {OpeningHours::OpeningHours.parse()}.to raise_error(ArgumentError)
      end
    end

    describe "with params that don't conform to the openingHours schema" do
      let(:bad_param_examples) {[
        "Mon 08:00-16:00",
        "08:00-16:00",
        "Mo 0800-16:00",
        "Mo 08:00-1600",
        "Mo 08:0016:00",
        "No 08:00-16:00",
        "Mo08:00-16:00",
        "Mo-Thu 08:00-16:00",
        "MoTh 08:00-16:00",
        "Mo-Th08:00-16:00"
      ]}

      it "raises an ArgumentError" do
        bad_param_examples.each do |bad_params|
          expect {OpeningHours::OpeningHours.parse(bad_params)}.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe "open_at?" do
    describe "params" do
      it "requires something that can be parsed with strftime" do
        param = DateTime.now
        expect(param).to receive(:to_datetime) { DateTime.now }
        it = OpeningHours::OpeningHours.parse(good_param_examples.sample)
        it.open_at?(param)
      end
    end

    describe "date/time within opening hours" do
      before do
        @it = OpeningHours::OpeningHours.parse(["Mo-Th 08:00-16:30", "Fr 08:00-16:00"])
      end

      it "returns true if date and time is the first mintue of open hours" do
        time = DateTime.parse("Monday, June 16 08:00")
        expect(@it.open_at?(time)).to be_truthy
      end

      it "returns true if date and time is the last minute of open hours" do
        time = DateTime.parse("Monday, June 16 16:30")
        expect(@it.open_at?(time)).to be_truthy
      end

      it "returns true for a time for each day in range" do
        %w(Tuesday Wednesday Thursday).each do |day|
          time = DateTime.parse("#{day}, June 16 16:30")
          expect(@it.open_at?(time)).to be_truthy
        end
      end

      it "returns true for a time for a single day" do
        time = DateTime.parse("Friday, June 16 12:30")
        expect(@it.open_at?(time)).to be_truthy
      end
    end

    describe "date/time outside opening hours" do
      before do
        @it = OpeningHours::OpeningHours.parse(["Mo-Th 08:00-16:30", "Fr 08:00-16:00"])
      end

      it "returns false if the time is before open hours" do
        time = DateTime.parse("Monday, June 16 07:59")
        expect(@it.open_at?(time)).to be_falsey
      end

      it "returns false if the time is after open hours" do
        time = DateTime.parse("Monday, June 16 16:31")
        expect(@it.open_at?(time)).to be_falsey
      end

      it "returns false if the time is in open hours, but on an unspecified day" do
        time = DateTime.parse("Saturday, June 21 12:30")
        expect(@it.open_at?(time)).to be_falsey
      end

      it "returns false if the time is in open hours for a different day, but not this day" do
        time = DateTime.parse("Friday, June 20 16:01")
        expect(@it.open_at?(time)).to be_falsey
      end
    end
  end
end
