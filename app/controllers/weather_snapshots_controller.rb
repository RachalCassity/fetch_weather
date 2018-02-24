require "net/http"

class WeatherSnapshotsController < ApplicationController
  before_action :set_weather_snapshot, only: [:show, :update, :destroy]

  def index
    @weather_snapshots = WeatherSnapshot.all
  end

  def show
    @weather_snapshot = WeatherSnapshot.find(params[:id])
  end

  def new
    @weather_snapshot = WeatherSnapshot.new
  end

  def edit
  end

  def create
    @weather_snapshot = WeatherSnapshot.new(weather_snapshot_params)
    if @weather_snapshot.zipcode
      uri = URI("http://api.openweathermap.org/data/2.5/weather")
      uri.query = URI.encode_www_form(zip: @weather_snapshot.zipcode, appid: ENV['WEATHER_API_KEY'])

      response = Net::HTTP.get_response(uri)
      if response.is_a?(Net::HTTPSuccess)
        json_response = JSON.parse(response.body)

        temperature_kelvin = json_response.dig("main", "temp")
        if temperature_kelvin
          @weather_snapshot.temperature_f = temperature_kelvin * 9/5 - 459.67
          @weather_snapshot.temperature_c = temperature_kelvin - 273.15
        end
      else
        respond_to do |format|
          format.html { redirect_to new_weather_snapshot_path, error: 'Could not fetch weather data.' }
          format.json { render json: {} }
        end

        return
      end
    end

    respond_to do |format|
      if @weather_snapshot.save
        format.html { redirect_to @weather_snapshot, notice: 'Weather data fetched.' }
        format.json { render :show, status: :created, location: @weather_snapshot }
      else
        format.html { render :new }
        format.json { render json: @weather_snapshot.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @weather_snapshot.update(weather_snapshot_params)
        format.html { redirect_to @weather_snapshot, notice: 'Weather shapshot was successfully updated.' }
        format.json { render :show, status: :ok, location: @weather_snapshot }
      else
        format.html { render :edit }
        format.json { render json: @weather_snapshot.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @weather_snapshot.destroy
    respond_to do |format|
      format.html { redirect_to weather_snapshots_url, notice: 'Weather snapshot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_weather_snapshot
      @weather_snapshot = WeatherSnapshot.find(params[:id])
    end

    def weather_snapshot_params
      params.require(:weather_snapshot).permit(:zipcode)
    end
end
