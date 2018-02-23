class WeatherDatum < ApplicationRecord
  validates :zipcode, presence: true
  validate :presence_of_temperature_data

  private

  def presence_of_temperature_data
    return if temperature_c.present? || temperature_f.present?
    errors.add(:temperature, "must be present")
  end
end
