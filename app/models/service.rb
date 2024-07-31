# frozen_string_literal: true

# Service model
class Service < ApplicationRecord
  has_many :work_schedules, dependent: :destroy, inverse_of: :service
  has_many :contract_schedules, dependent: :destroy, inverse_of: :service

  validates :name, presence: true
end
