# frozen_string_literal: true

# Engineer model
class Engineer < ApplicationRecord
  has_many :work_schedules, dependent: :destroy, inverse_of: :engineer

  validates :name, presence: true
end
