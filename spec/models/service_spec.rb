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

  it 'has many work_schedules' do
    association = Service.reflect_on_association(:work_schedules)
    expect(association.macro).to eq :has_many
  end

  it 'can have many work_schedules' do
    service = create(:service)
    schedule1 = create(:work_schedule, service:)
    schedule2 = create(:work_schedule, service:)
    expect(service.work_schedules).to include(schedule1, schedule2)
  end
end
