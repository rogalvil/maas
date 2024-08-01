# frozen_string_literal: true

FactoryBot.define do
  factory :service do
    sequence(:name) { |n| "Service Name #{n}" }
  end
end
