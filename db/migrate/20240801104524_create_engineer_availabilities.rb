class CreateEngineerAvailabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :engineer_availabilities do |t|
      t.references :engineer, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.integer :year, null: false
      t.integer :week, null: false
      t.integer :day_of_week, null: false
      t.integer :hour, null: false

      t.timestamps
    end
  end
end
