FactoryBot.define do
  factory :contract_schedule do
    association :service
    day { 'monday' }
    start_time { 9 }
    end_time { 17 }
  end
end
