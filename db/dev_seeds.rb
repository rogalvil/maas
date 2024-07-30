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
  { name: 'Monitoring Service A' },
  { name: 'Monitoring Service B' },
  { name: 'Monitoring Service C' }
].each do |service_attributes|
  Service.create_with(
    service_attributes
  ).find_or_initialize_by(name: service_attributes[:name]).tap do |service|
    service.update!(service_attributes)
  end
end
