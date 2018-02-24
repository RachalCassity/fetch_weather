require "rails_helper"

RSpec.describe WeatherDatum, :type => :model do

  describe "validations" do
  	context "presence of zipcode" do
	    it do
	      is_expected.to validate_presence_of(:zipcode)
	    end
	  end
  end
end
