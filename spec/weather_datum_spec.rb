require "rails_helper"

RSpec.describe WeatherDatum, :type => :model do

  describe "validations" do
  	context "presence of zipcode" do
	    it do
	      is_expected.to validate_presence_of(:zipcode)
	    end
	  end

	  context "return if temperature_data is nil" do
	    it do
	      is_expected.to return_error_of(:temperature_data)
	    end
	  end
  end
end
