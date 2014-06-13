require "rspec/core"
require_relative "../lib/opening_hours"

describe OpeningHours::OpeningHours do
  describe "parse" do
    describe "with good params" do
      let(:good_param_examples) {[
        ["Mo-Th 08:00-16:30", "Fr 08:00-16:00"],
        "Mo-Th 08:00-16:30",
      ]}

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
end
