require "net/http"

class WeatherDataController < ApplicationController
  before_action :set_weather_datum, only: [:show, :create, :update, :destroy]

  def index
    @weather_data = WeatherDatum.all
  end

  def show
    @weather_datum = WeatherDatum.find(params[:id])
  end

  def new
    @weather_datum = WeatherDatum.new
  end

  def edit
  end

  def create
    @weather_datum = WeatherDatum.new(weather_datum_params)

    if @weather_datum.zipcode
      @weather_datum.zipcode = WeatherDatum.all(zipcode: @weather_datum.zipcode)
    end

    if @weather_datum.zipcode
      uri = URI("http://api.openweathermap.org/data/2.5/weather")
      uri.query = URI.encode_www_form(zip: @weather_datum.zipcode, appid: ENV['WEATHER_API_KEY'])

      response = Net::HTTP.get_response(uri)
      if response.is_a?(Net::HTTPSuccess)
        json_response = JSON.parse(response.body)

        temperature_kelvin = json_response.dig("main", "temp")
        if temperature_kelvin
          @weather_datum.temperature_f = temperature_kelvin * 9/5 - 459.67
          @weather_datum.temperature_c = temperature_kelvin - 273.15
        end
      end
    end

    respond_to do |format|
      if @weather_datum.save
        format.html { redirect_to @weather_datum, notice: 'Weather data fetched.' }
        format.json { render :show, status: :created, location: @weather_datum }
      else
        format.html { render :new }
        format.json { render json: @weather_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @weather_datum.update(weather_datum_params)
        format.html { redirect_to @weather_datum, notice: 'Weather datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @weather_datum }
      else
        format.html { render :edit }
        format.json { render json: @weather_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @weather_datum.destroy
    respond_to do |format|
      format.html { redirect_to weather_data_url, notice: 'Weather datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_weather_datum
      @weather_datum = WeatherDatum.find(params[:id])
    end

    def weather_datum_params
      params.require(:weather_datum).permit(:zipcode)
    end
end
