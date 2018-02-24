require "rails_helper"

RSpec.describe WeatherSnapshotsController, :type => :controller do
  describe "GET index" do
    let!(:weather_snapshot) { FactoryBot.create(:weather_snapshot) }

    it "returns weather data" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST create" do
    context "when you send a zipcode"do
      it "fetches a upi and responds with temperature data" do
        post :create, params: { weather_snapshot: { zipcode: 90210 } }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
