# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service, type: :model do
  it 'is valid with valid attributes' do
    service = build(:service)
    expect(service).to be_valid
  end

  it 'is not valid without a name' do
    service = build(:service, name: nil)
    expect(service).to_not be_valid
  end

  it 'has many work schedules' do
    association = Service.reflect_on_association(:work_schedules)
    expect(association.macro).to eq :has_many
  end

  it 'can have many work schedules' do
    service = create(:service)
    schedule1 = create(:work_schedule, service:)
    schedule2 = create(:work_schedule, service:)
    expect(service.work_schedules).to include(schedule1, schedule2)
  end

  it 'has many contract schedules' do
    association = Service.reflect_on_association(:contract_schedules)
    expect(association.macro).to eq :has_many
  end

  it 'can have many contract schedules' do
    service = create(:service)
    contract_schedule1 = create(:contract_schedule, service:, day: 'monday', start_time: 9, end_time: 17)
    contract_schedule2 = create(:contract_schedule, service:, day: 'tuesday', start_time: 9, end_time: 17)
    expect(service.contract_schedules).to include(contract_schedule1, contract_schedule2)
  end

  it 'destroys associated contract schedules when deleted' do
    service = create(:service)
    create(:contract_schedule, service:)
    expect { service.destroy }.to change { ContractSchedule.count }.by(-1)
  end
end
