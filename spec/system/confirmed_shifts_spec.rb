# frozen_string_literal: true

require 'system_helper'
require 'date'

RSpec.describe 'Confirmed Shifts Page', type: :system do
  let(:expected_weeks) do
    current_date = Date.today
    expected_weeks = []
    6.times do |i|
      future_date = current_date + (i * 7)
      week_number = future_date.cweek
      year = future_date.year
      year += 1 if future_date.year > current_date.year
      expected_weeks << "Semana #{week_number} del #{year}"
    end
    expected_weeks
  end

  let(:service) { create(:service, name: 'Monitoring Service A') }
  let(:engineer) { create(:engineer, name: 'Andrea Andrade') }
  let(:contract_schedules) do
    monday = create(:contract_schedule, service:, day: 'monday', start_time: 18, end_time: 23)
    tuesday = create(:contract_schedule, service:, day: 'tuesday', start_time: 18, end_time: 23)
    wednesday = create(:contract_schedule, service:, day: 'wednesday', start_time: 18, end_time: 23)
    thursday = create(:contract_schedule, service:, day: 'thursday', start_time: 18, end_time: 23)
    friday = create(:contract_schedule, service:, day: 'friday', start_time: 18, end_time: 23)
    saturday = create(:contract_schedule, service:, day: 'saturday', start_time: 14, end_time: 22)
    sunday = create(:contract_schedule, service:, day: 'sunday', start_time: 16, end_time: 24)
    [monday, tuesday, wednesday, thursday, friday, saturday, sunday]
  end

  it 'shows no data available when there are no services, weeks, engineers, or work schedules' do
    visit confirmed_shifts_path

    expect(page).to have_content('Turnos confirmados')

    service_selector = find('div.v-select', text: 'Selecciona un servicio')
    service_selector.find('.v-field__field').click
    expect(page).to have_content('No data available')

    service_selector = find('div.v-select', text: 'Selecciona una semana')
    service_selector.find('.v-field__field').click

    expected_weeks.each do |expected_week|
      expect(page).to have_content(expected_week)
    end
  end

  it 'selects an engineer and a week and shows the corresponding schedule' do
    service
    engineer
    contract_schedules
    visit confirmed_shifts_path

    week_selector = find('div.v-select', text: 'Selecciona una semana')
    week_selector.find('.v-field__field').click
    find('div.v-overlay-container > div > div', text: expected_weeks.first).click

    service_selector = find('div.v-select', text: 'Selecciona un servicio')
    service_selector.find('.v-field__field').click
    find('div.v-overlay-container > div > div', text: service.name).click

    take_screenshot
    expect(page).to have_content(engineer.name)

    expect(page).to have_content('Sin asignar')
    within('#engineer-hours-table.v-data-table') do
      alice_row = find('div.v-chip__content', text: engineer.name).find(:xpath, './ancestor::tr')
      assigned_hours_alice = alice_row.find('td:nth-child(2)').text.to_i
      expect(assigned_hours_alice).to eq(0)

      alice_row = find('div.v-chip__content', text: 'Sin asignar').find(:xpath, './ancestor::tr')
      assigned_hours_alice = alice_row.find('td:nth-child(2)').text.to_i
      expect(assigned_hours_alice).to eq(41)
    end
  end
end
