class CreateWeatherSnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :weather_snapshots do |t|
      t.text :zipcode
      t.integer :temperature_f
      t.integer :temperature_c

      t.timestamps
    end
  end
end
