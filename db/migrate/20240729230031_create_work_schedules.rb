class CreateWorkSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :work_schedules do |t|
      t.references :engineer, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.integer :week, null: false
      t.integer :day, null: false
      t.integer :hour, null: false
      t.boolean :assigned, null: false, default: false

      t.timestamps
    end
  end
end
