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

[
  {
    name: 'Monitoring Service A',
    schedule: [
      { day: 'monday', start_time: 8, end_time: 16 },
      { day: 'tuesday', start_time: 9, end_time: 17 },
      { day: 'wednesday', start_time: 10, end_time: 18 },
      { day: 'thursday', start_time: 8, end_time: 16 },
      { day: 'friday', start_time: 9, end_time: 17 },
      { day: 'saturday', start_time: 10, end_time: 14 },
      { day: 'sunday', start_time: 10, end_time: 14 }
    ]
  },
  {
    name: 'Monitoring Service B',
    schedule: [
      { day: 'monday', start_time: 12, end_time: 20 },
      { day: 'tuesday', start_time: 12, end_time: 20 },
      { day: 'wednesday', start_time: 14, end_time: 22 },
      { day: 'thursday', start_time: 12, end_time: 20 },
      { day: 'friday', start_time: 12, end_time: 20 },
      { day: 'saturday', start_time: 10, end_time: 18 },
      { day: 'sunday', start_time: 10, end_time: 18 }
    ]
  },
  {
    name: 'Monitoring Service C',
    schedule: [
      { day: 'monday', start_time: 18, end_time: 24 },
      { day: 'tuesday', start_time: 16, end_time: 22 },
      { day: 'wednesday', start_time: 16, end_time: 24 },
      { day: 'thursday', start_time: 18, end_time: 24 },
      { day: 'friday', start_time: 18, end_time: 23 },
      { day: 'saturday', start_time: 10, end_time: 24 },
      { day: 'sunday', start_time: 12, end_time: 20 }
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
