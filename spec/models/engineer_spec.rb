# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Engineer, type: :model do
  it 'is valid with valid attributes' do
    engineer = build(:engineer)
    expect(engineer).to be_valid
  end

  it 'is not valid without a name' do
    engineer = build(:engineer, name: nil)
    expect(engineer).to_not be_valid
  end

  it 'has many work_schedules' do
    association = Engineer.reflect_on_association(:work_schedules)
    expect(association.macro).to eq :has_many
  end

  it 'can have many work_schedules' do
    engineer = create(:engineer)
    schedule1 = create(:work_schedule, engineer:)
    schedule2 = create(:work_schedule, engineer:)
    expect(engineer.work_schedules).to include(schedule1, schedule2)
  end
end
