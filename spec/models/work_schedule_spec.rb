# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkSchedule, type: :model do
  it 'is valid with an engineer, service, week, day, hour, and assigned' do
    work_schedule = build(:work_schedule)
    expect(work_schedule).to be_valid
  end

  it 'is invalid without a week' do
    work_schedule = build(:work_schedule, week: nil)
    work_schedule.valid?
    expect(work_schedule.errors[:week]).to include("can't be blank")
  end

  it 'is invalid without a day of week' do
    work_schedule = build(:work_schedule, day_of_week: nil)
    work_schedule.valid?
    expect(work_schedule.errors[:day_of_week]).to include("can't be blank")
  end

  it 'is invalid without an hour' do
    work_schedule = build(:work_schedule, hour: nil)
    work_schedule.valid?
    expect(work_schedule.errors[:hour]).to include("can't be blank")
  end

  it 'is invalid without assigned' do
    work_schedule = FactoryBot.build(:work_schedule, assigned: nil)
    expect(work_schedule).to_not be_valid
    expect(work_schedule.errors[:assigned]).to include('is not included in the list')
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
    work_schedule = create(:work_schedule, engineer:, service:)
    expect(work_schedule.engineer).to eq(engineer)
    expect(work_schedule.service).to eq(service)
  end
end
