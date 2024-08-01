# frozen_string_literal: true

# Contract Schedule model for schedule of service
class ContractSchedule < ApplicationRecord
  belongs_to :service, inverse_of: :contract_schedules

  validates :day, presence: true, inclusion: {
    in: %w[monday tuesday wednesday thursday friday saturday sunday]
  }
  validates :day, uniqueness: { scope: :service_id }
  validates :start_time, :end_time, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 24
  }
  validate :start_time_before_end_time

  private

  def start_time_before_end_time
    return unless start_time.present? && end_time.present?

    errors.add(:start_time, 'must be before end time') if start_time >= end_time
  end
end
