# frozen_string_literal: true

# Engineer model
class Engineer < ApplicationRecord
  before_create :assign_unique_color

  has_many :work_schedules, dependent: :destroy, inverse_of: :engineer

  validates :name, presence: true

  private

  def assign_unique_color
    self.color = generate_unique_color
  end

  def generate_unique_color
    loop do
      color = "##{SecureRandom.hex(3)}"
      break color unless self.class.exists?(color:)
    end
  end
end
