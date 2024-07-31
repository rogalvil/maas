class UpdateWorkSchedules < ActiveRecord::Migration[7.0]
  def change
    # Add the year column to the work_schedules table
    add_column :work_schedules, :year, :integer, null: false

    # Add the work date column to the work_schedules table
    add_column :work_schedules, :work_date, :date, null: false

    # Rename the day column to day_of_week
    rename_column :work_schedules, :day, :day_of_week

    # Add indexes to the year, day_of_week, and work date columns
    add_index :work_schedules, :year
    add_index :work_schedules, :work_date
    add_index :work_schedules, :day_of_week
  end
end
