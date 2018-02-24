require "rails_helper"

RSpec.describe WeatherDataController, :type => :controller do
	
	describe "GET index" do
		it "returns weather data" do
			create(:weather_data)
		end
	end

  describe "POST create" do
  	context "when you send a zipcode"do
	    it "fetches a upi and responds with temperature data" do
	    	post :create
	    end
	  end
  end
end
