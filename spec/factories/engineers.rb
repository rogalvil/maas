# frozen_string_literal: true

FactoryBot.define do
  factory :engineer do
    sequence(:name) { |n| "Engineer Name #{n}" }
  end
end
