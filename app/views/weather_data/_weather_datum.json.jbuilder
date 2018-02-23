json.extract! weather_datum, :id, :zipcode, :temperature_f, :temperature_c, :created_at, :updated_at
json.url weather_datum_url(weather_datum, format: :json)
