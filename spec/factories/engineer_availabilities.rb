FactoryBot.define do
  factory :engineer_availability do
    association :engineer
    association :service
    year { 2021 }
    week { 1 }
    day_of_week { 1 }
    hour { 1 }
  end
end
