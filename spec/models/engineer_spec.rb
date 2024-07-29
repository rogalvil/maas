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
end
