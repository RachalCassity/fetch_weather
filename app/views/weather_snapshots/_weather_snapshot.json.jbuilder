json.extract! weather_snapshot, :id, :zipcode, :temperature_f, :temperature_c, :created_at, :updated_at
json.url weather_snapshot_url(weather_snapshot, format: :json)
