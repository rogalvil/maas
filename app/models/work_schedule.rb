# frozen_string_literal: true

# WorkSchedule model
class WorkSchedule < ApplicationRecord
  belongs_to :engineer, inverse_of: :work_schedules
  belongs_to :service, inverse_of: :work_schedules

  validates :week, :day, :hour, presence: true
  validates :assigned, inclusion: { in: [true, false] }
end
