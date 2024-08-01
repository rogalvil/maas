# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContractSchedule, type: :model do
  it 'is valid with valid attributes' do
    contract_schedule = build(:contract_schedule)
    expect(contract_schedule).to be_valid
  end

  it 'is invalid without a day' do
    contract_schedule = build(:contract_schedule, day: nil)
    expect(contract_schedule).not_to be_valid
  end

  it 'is invalid with an incorrect day' do
    contract_schedule = build(:contract_schedule, day: 'invalid_day')
    expect(contract_schedule).not_to be_valid
  end

  it 'is invalid without a start_time' do
    contract_schedule = build(:contract_schedule, start_time: nil)
    expect(contract_schedule).not_to be_valid
  end

  it 'is invalid without an end_time' do
    contract_schedule = build(:contract_schedule, end_time: nil)
    expect(contract_schedule).not_to be_valid
  end

  it 'is invalid if start_time is not before end_time' do
    contract_schedule = build(:contract_schedule, start_time: 18, end_time: 17)
    expect(contract_schedule).not_to be_valid
  end

  it 'is invalid with a start_time outside 0-24 range' do
    contract_schedule = build(:contract_schedule, start_time: 25)
    expect(contract_schedule).not_to be_valid
  end

  it 'is invalid with an end_time outside 0-24 range' do
    contract_schedule = build(:contract_schedule, end_time: 25)
    expect(contract_schedule).not_to be_valid
  end

  it 'belongs to service' do
    association = WorkSchedule.reflect_on_association(:service)
    expect(association.macro).to eq :belongs_to
  end

  it 'can belongs to a service' do
    service = create(:service)
    contract_schedule = create(:contract_schedule, service:)
    expect(contract_schedule.service).to be_present
    expect(contract_schedule.service).to eq(service)
  end
end
