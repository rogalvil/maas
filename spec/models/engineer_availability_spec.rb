# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EngineerAvailability, type: :model do
  it 'is valid with an engineer, service, week, day of week , hour' do
    engineer_availability = build(:engineer_availability)
    expect(engineer_availability).to be_valid
  end

  it 'is invalid without a week' do
    engineer_availability = build(:engineer_availability, week: nil)
    engineer_availability.valid?
    expect(engineer_availability.errors[:week]).to include("can't be blank")
  end

  it 'is invalid without a day of week' do
    engineer_availability = build(:engineer_availability, day_of_week: nil)
    engineer_availability.valid?
    expect(engineer_availability.errors[:day_of_week]).to include("can't be blank")
  end

  it 'is invalid without an hour' do
    engineer_availability = build(:engineer_availability, hour: nil)
    engineer_availability.valid?
    expect(engineer_availability.errors[:hour]).to include("can't be blank")
  end

  it 'belongs to engineer' do
    association = WorkSchedule.reflect_on_association(:engineer)
    expect(association.macro).to eq :belongs_to
  end

  it 'belongs to service' do
    association = WorkSchedule.reflect_on_association(:service)
    expect(association.macro).to eq :belongs_to
  end

  it 'can belong to an engineer and a service' do
    engineer = create(:engineer)
    service = create(:service)
    engineer_availability = create(:engineer_availability, engineer:, service:)
    expect(engineer_availability.engineer).to eq(engineer)
    expect(engineer_availability.service).to eq(service)
  end
end
