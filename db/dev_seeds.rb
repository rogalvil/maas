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

# Set up services and contract schedules
[
  {
    name: 'Monitoring Service A',
    schedule: [
      { day: 'monday', start_time: 19, end_time: 23 },
      { day: 'tuesday', start_time: 19, end_time: 23 },
      { day: 'wednesday', start_time: 19, end_time: 23 },
      { day: 'thursday', start_time: 19, end_time: 23 },
      { day: 'friday', start_time: 19, end_time: 23 },
      { day: 'saturday', start_time: 10, end_time: 23 },
      { day: 'sunday', start_time: 10, end_time: 23 }
    ]
  },
  {
    name: 'Monitoring Service B',
    schedule: [
      { day: 'monday', start_time: 16, end_time: 22 },
      { day: 'tuesday', start_time: 16, end_time: 22 },
      { day: 'wednesday', start_time: 14, end_time: 21 },
      { day: 'thursday', start_time: 14, end_time: 21 },
      { day: 'friday', start_time: 14, end_time: 23 },
      { day: 'saturday', start_time: 7, end_time: 23 },
      { day: 'sunday', start_time: 7, end_time: 22 }
    ]
  },
  {
    name: 'Monitoring Service C',
    schedule: [
      { day: 'monday', start_time: 14, end_time: 20 },
      { day: 'tuesday', start_time: 14, end_time: 20 },
      { day: 'wednesday', start_time: 16, end_time: 22 },
      { day: 'thursday', start_time: 17, end_time: 23 },
      { day: 'friday', start_time: 18, end_time: 22 },
      { day: 'saturday', start_time: 8, end_time: 22 },
      { day: 'sunday', start_time: 8, end_time: 22 }
    ]
  }
].each do |service_attributes|
  Service.create_with(
    service_attributes.except(:schedule)
  ).find_or_initialize_by(name: service_attributes[:name]).tap do |service|
    service.update!(service_attributes.except(:schedule))
    service_attributes[:schedule].each do |schedule_attributes|
      ContractSchedule.create_with(
        schedule_attributes
      ).find_or_initialize_by(service:, day: schedule_attributes[:day]).tap do |schedule|
        schedule.update!(schedule_attributes)
      end
    end
  end
end


# # Set up work schedules
# week_data = [
#   {
#     year: 2024,
#     week: 29,
#     schedules: [
#       # Monitoring Service A
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 1, hours: [8, 9, 10, 11, 12] }, # Monday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 1, hours: [13, 14, 15] }, # Monday
#       { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 2, hours: [9, 10, 11, 12] }, # Tuesday
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 2, hours: [13, 14, 15] }, # Tuesday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 3, hours: [10, 11, 12] }, # Wednesday
#       { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 3, hours: [13, 14, 15, 16] }, # Wednesday
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 4, hours: [8, 9, 10, 11, 12] }, # Thursday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 4, hours: [13, 14, 15] }, # Thursday
#       { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 5, hours: [9, 10, 11, 12] }, # Friday
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 5, hours: [13, 14, 15] }, # Friday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 6, hours: [10, 11, 12] }, # Saturday
#       { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 6, hours: [13] }, # Saturday
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 7, hours: [10, 11] }, # Sunday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 7, hours: [12] }, # Sunday

#       # Monitoring Service B
#       { service: 'Monitoring Service B', engineer: 'Alice Johnson', day_of_week: 1, hours: [12, 13, 14, 15] }, # Monday
#       { service: 'Monitoring Service B', engineer: 'Bob Smith', day_of_week: 1, hours: [16, 17, 18] }, # Monday
#       { service: 'Monitoring Service B', engineer: 'Charlie Davis', day_of_week: 2, hours: [12, 13, 14, 15] }, # Tuesday
#       { service: 'Monitoring Service B', engineer: 'Alice Johnson', day_of_week: 2, hours: [16, 17, 18] }, # Tuesday
#       { service: 'Monitoring Service B', engineer: 'Bob Smith', day_of_week: 3, hours: [14, 15, 16] }, # Wednesday
#       { service: 'Monitoring Service B', engineer: 'Charlie Davis', day_of_week: 3, hours: [17, 18, 19, 20] }, # Wednesday
#       { service: 'Monitoring Service B', engineer: 'Alice Johnson', day_of_week: 4, hours: [12, 13, 14, 15] }, # Thursday
#       { service: 'Monitoring Service B', engineer: 'Bob Smith', day_of_week: 4, hours: [16, 17, 18] }, # Thursday
#       { service: 'Monitoring Service B', engineer: 'Charlie Davis', day_of_week: 5, hours: [12, 13, 14, 15] }, # Friday
#       { service: 'Monitoring Service B', engineer: 'Alice Johnson', day_of_week: 5, hours: [16, 17, 18] }, # Friday
#       { service: 'Monitoring Service B', engineer: 'Bob Smith', day_of_week: 6, hours: [10, 11, 12, 13] }, # Saturday
#       { service: 'Monitoring Service B', engineer: 'Charlie Davis', day_of_week: 6, hours: [14, 15, 16] }, # Saturday
#       { service: 'Monitoring Service B', engineer: 'Alice Johnson', day_of_week: 7, hours: [10, 11, 12] }, # Sunday
#       { service: 'Monitoring Service B', engineer: 'Bob Smith', day_of_week: 7, hours: [13, 14, 15] } # Sunday
#     ]
#   },
#   {
#     year: 2024,
#     week: 30,
#     schedules: [
#       # Monitoring Service A
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 1, hours: [8, 9, 10, 11, 12, 13] }, # Monday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 1, hours: [14, 15, 16] }, # Monday
#       { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 2, hours: [9, 10, 11, 12, 13] }, # Tuesday
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 2, hours: [14, 15, 16] }, # Tuesday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 3, hours: [10, 11, 12, 13] }, # Wednesday
#       { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 3, hours: [14, 15, 16] }, # Wednesday
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 4, hours: [8, 9, 10, 11] }, # Thursday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 4, hours: [12, 13, 14, 15, 16] }, # Thursday
#       { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 5, hours: [9, 10, 11, 12] }, # Friday
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 5, hours: [13, 14, 15] }, # Friday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 6, hours: [10, 11, 12, 13] }, # Saturday
#       { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 7, hours: [10, 11, 12] }, # Sunday
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 7, hours: [13, 14] }, # Sunday

#       # Monitoring Service B
#       { service: 'Monitoring Service B', engineer: 'Alice Johnson', day_of_week: 1, hours: [12, 13, 14, 15] }, # Monday
#       { service: 'Monitoring Service B', engineer: 'Bob Smith', day_of_week: 1, hours: [16, 17, 18, 19] }, # Monday
#       { service: 'Monitoring Service B', engineer: 'Charlie Davis', day_of_week: 2, hours: [12, 13, 14, 15] }, # Tuesday
#       { service: 'Monitoring Service B', engineer: 'Alice Johnson', day_of_week: 2, hours: [16, 17, 18, 19] }, # Tuesday
#       { service: 'Monitoring Service B', engineer: 'Bob Smith', day_of_week: 3, hours: [14, 15, 16, 17] }, # Wednesday
#       { service: 'Monitoring Service B', engineer: 'Charlie Davis', day_of_week: 3, hours: [18, 19, 20] }, # Wednesday
#       { service: 'Monitoring Service B', engineer: 'Alice Johnson', day_of_week: 4, hours: [12, 13, 14, 15] }, # Thursday
#       { service: 'Monitoring Service B', engineer: 'Bob Smith', day_of_week: 4, hours: [16, 17, 18, 19] }, # Thursday
#       { service: 'Monitoring Service B', engineer: 'Charlie Davis', day_of_week: 5, hours: [12, 13, 14, 15] }, # Friday
#       { service: 'Monitoring Service B', engineer: 'Alice Johnson', day_of_week: 5, hours: [16, 17, 18, 19] }, # Friday
#       { service: 'Monitoring Service B', engineer: 'Bob Smith', day_of_week: 6, hours: [10, 11, 12, 13] }, # Saturday
#       { service: 'Monitoring Service B', engineer: 'Charlie Davis', day_of_week: 7, hours: [10, 11, 12, 13] }, # Sunday
#     ]
#   },
#   {
#     year: 2024,
#     week: 31,
#     schedules: [
#       # Monitoring Service A
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 1, hours: [8, 9, 10, 11, 12, 13, 14] }, # Monday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 2, hours: [9, 10, 11, 12, 13, 14, 15] }, # Tuesday
#       { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 3, hours: [10, 11, 12, 13, 14, 15, 16] }, # Wednesday
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 4, hours: [8, 9, 10, 11, 12, 13, 14] }, # Thursday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 5, hours: [9, 10, 11, 12, 13, 14, 15] }, # Friday
#       { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 6, hours: [10, 11, 12, 13] }, # Saturday
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 7, hours: [10, 11, 12] }, # Sunday

#       # Monitoring Service B
#       { service: 'Monitoring Service B', engineer: 'Alice Johnson', day_of_week: 1, hours: [12, 13, 14, 15, 16, 17, 18] }, # Monday
#       { service: 'Monitoring Service B', engineer: 'Bob Smith', day_of_week: 2, hours: [12, 13, 14, 15, 16, 17, 18] }, # Tuesday
#       { service: 'Monitoring Service B', engineer: 'Charlie Davis', day_of_week: 3, hours: [14, 15, 16, 17, 18, 19, 20] }, # Wednesday
#       { service: 'Monitoring Service B', engineer: 'Alice Johnson', day_of_week: 4, hours: [12, 13, 14, 15, 16, 17, 18] }, # Thursday
#       { service: 'Monitoring Service B', engineer: 'Bob Smith', day_of_week: 5, hours: [12, 13, 14, 15, 16, 17, 18] }, # Friday
#       { service: 'Monitoring Service B', engineer: 'Charlie Davis', day_of_week: 6, hours: [10, 11, 12, 13, 14, 15, 16] }, # Saturday
#       { service: 'Monitoring Service B', engineer: 'Alice Johnson', day_of_week: 7, hours: [10, 11, 12, 13, 14, 15, 16] } # Sunday
#     ]
#   }
# ]
# week_data.each do |week|
#   week_number = week[:week]
#   year = week[:year]
#   week[:schedules].each do |entry|
#     engineer = Engineer.find_by(name: entry[:engineer])
#     service = Service.find_by(name: entry[:service])
#     day_of_week = entry[:day_of_week]
#     work_date = Date.commercial(year, week_number, day_of_week)
#     day_name = work_date.strftime('%A').downcase
#     contract_schedule = service.contract_schedules.find_by(day: day_name)
#     next unless contract_schedule

#     entry[:hours].each do |hour|
#       next unless hour >= contract_schedule.start_time && hour < contract_schedule.end_time

#       WorkSchedule.find_or_initialize_by(
#         service:,
#         engineer:,
#         year:,
#         week: week_number,
#         day_of_week:,
#         hour:,
#         work_date:
#       ).tap do |work_schedule|
#         work_schedule.update!(assigned: true)
#       end
#     end
#   end
# end

# # Set up engineer availabilities
# week_data = [
#   {
#     year: 2024,
#     week: 32,
#     schedules: [
#       # Monitoring Service A
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 1, hours: [8, 9, 10, 11, 12] }, # Monday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 1, hours: [8, 9, 10, 11, 12, 13, 14, 15] }, # Monday
#       { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 2, hours: [9, 10, 11, 12] }, # Tuesday
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 2, hours: [9, 10, 11, 12, 13, 14, 15] }, # Tuesday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 3, hours: [10, 11, 12, 13, 14, 15] }, # Wednesday
#       { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 3, hours: [13, 14, 15, 16] }, # Wednesday
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 4, hours: [8, 9, 10, 11, 12] }, # Thursday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 4, hours: [10, 11, 12, 13, 14, 15] }, # Thursday
#       { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 5, hours: [9, 10, 11, 12] }, # Friday
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 5, hours: [11, 12, 13, 14, 15] }, # Friday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 6, hours: [10, 11, 12, 13] }, # Saturday
#       { service: 'Monitoring Service A', engineer: 'Charlie Davis', day_of_week: 6, hours: [10, 13] }, # Saturday
#       { service: 'Monitoring Service A', engineer: 'Alice Johnson', day_of_week: 7, hours: [10, 11] }, # Sunday
#       { service: 'Monitoring Service A', engineer: 'Bob Smith', day_of_week: 7, hours: [10, 12] } # Sunday
#     ]
#   }
# ]
# week_data.each do |week|
#   week_number = week[:week]
#   year = week[:year]
#   week[:schedules].each do |entry|
#     engineer = Engineer.find_by(name: entry[:engineer])
#     service = Service.find_by(name: entry[:service])
#     day_of_week = entry[:day_of_week]
#     date = Date.commercial(year, week_number, day_of_week)
#     day_name = date.strftime('%A').downcase
#     contract_schedule = service.contract_schedules.find_by(day: day_name)
#     next unless contract_schedule

#     entry[:hours].each do |hour|
#       next unless hour >= contract_schedule.start_time && hour < contract_schedule.end_time

#       EngineerAvailability.find_or_create_by(
#         service:,
#         engineer:,
#         year:,
#         week: week_number,
#         day_of_week:,
#         hour:
#       )
#     end
#   end
# end
