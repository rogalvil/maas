class CreateContractSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :contract_schedules do |t|
      t.references :service, null: false, foreign_key: true
      t.string :day, null: false
      t.integer :start_time, null: false
      t.integer :end_time, null: false

      t.timestamps
    end

    add_index :contract_schedules, %i[service_id day], unique: true
  end
end
