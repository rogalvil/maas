FactoryBot.define do
  factory :work_schedule do
    association :engineer
    association :service
    week { 1 }
    day { 1 }
    hour { 1 }
    assigned { false }
  end
end
