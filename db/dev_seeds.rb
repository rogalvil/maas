# frozen_string_literal: true

# Set up engineers
[
  { name: 'Alice Johnson' },
  { name: 'Bob Smith' },
  { name: 'Charlie Davis' }
].each do |engineer_attributes|
  Engineer.create_with(
    engineer_attributes
  ).find_or_initialize_by(name: engineer_attributes[:name]).tap do |engineer|
    engineer.update!(engineer_attributes)
  end
end

# Set up services with their schedules
week_data = {
  year: 2024,
  week: 31,
  schedules: [
    { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 1, hours: [8, 9, 10] },
    { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 2, hours: [12, 13, 14, 15, 16] },
    { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 3, hours: [12, 13, 14, 15, 16] },
    { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 5, hours: [14, 15, 16] },
    { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 7, hours: [10, 11, 12, 13] },
    { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 1, hours: [14, 15] },
    { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 2, hours: [9, 10] },
    { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 4, hours: [9, 10, 12, 15] },
    { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 4, hours: [13, 14] },
    { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 5, hours: [10, 11, 12] },
    { service: 'Monitoring Service B', engineer: 'Charlie Davis', day_of_week: 5, hours: [12, 13] },
    { service: 'Monitoring Service C', engineer: 'Charlie Davis', day_of_week: 3, hours: [16] },
    { service: 'Monitoring Service C', engineer: 'Alice Johnson', day_of_week: 6, hours: [14, 15] },
    { service: 'Monitoring Service C', engineer: 'Bob Smith', day_of_week: 1, hours: [19, 21, 22] }
  ]
}

engineers = Engineer.all
services = Service.all
week = week_data[:week]
year = week_data[:year]

week_data[:schedules].each do |entry|
  engineer = engineers.find_by(name: entry[:engineer])
  service = services.find_by(name: entry[:service])
  day_of_week = entry[:day_of_week]
  work_date = Date.commercial(year, week, day_of_week)
  day_name = work_date.strftime('%A').downcase
  contract_schedule = service.contract_schedules.find_by(day: day_name)
  next unless contract_schedule

  entry[:hours].each do |hour|
    next unless hour >= contract_schedule.start_time && hour < contract_schedule.end_time

    WorkSchedule.find_or_initialize_by(
      service:,
      engineer:,
      year:,
      week:,
      day_of_week:,
      hour:,
      work_date:
    ).tap do |work_schedule|
      work_schedule.update!(assigned: true)
    end
  end
end
