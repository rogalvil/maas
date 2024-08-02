# frozen_string_literal: true

# Engineer Availability model for availability of engineer
class EngineerAvailability < ApplicationRecord
  belongs_to :engineer, inverse_of: :engineer_availabilities
  belongs_to :service, inverse_of: :engineer_availabilities

  validates :year, :week, :day_of_week, :hour, presence: true
end
