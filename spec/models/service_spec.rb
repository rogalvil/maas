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
end
