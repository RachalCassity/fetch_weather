class CreateWeatherData < ActiveRecord::Migration[5.1]
  def change
    create_table :weather_data do |t|
      t.text :zipcode
      t.integer :temperature_f
      t.integer :temperature_c

      t.timestamps
    end
  end
end
