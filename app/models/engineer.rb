# frozen_string_literal: true

# Engineer model
class Engineer < ApplicationRecord
  validates :name, presence: true
end
