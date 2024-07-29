# frozen_string_literal: true

# Service model
class Service < ApplicationRecord
  validates :name, presence: true
end
