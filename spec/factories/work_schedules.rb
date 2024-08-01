FactoryBot.define do
  factory :work_schedule do
    association :engineer
    association :service
    week { 1 }
    day_of_week { 1 }
    hour { 1 }
    year { 2021 }
    work_date { '2021-01-01' }
    assigned { false }
  end
end
