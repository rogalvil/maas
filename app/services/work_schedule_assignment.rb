# frozen_string_literal: true

# Assign work schedules for a service to year and week
class WorkScheduleAssignment
  def initialize(service_id, year, week)
    @service_id = service_id
    @year = year
    @week = week
    @contract_schedules = ContractSchedule.where(service_id:)
    @engineer_availabilities = EngineerAvailability.where(service_id:, year:, week:)
    @engineers = Engineer.all
    @assign_work_schedules = []
  end

  def assign_work_schedules
    @contract_schedules.each do |schedule|
      process_schedule(schedule)
      p '----------------'
    end

    @assign_work_schedules
  end

  def save_work_schedules
    WorkSchedule.where(service_id: @service_id, year: @year, week: @week).destroy_all
    @assign_work_schedules.each do |work_schedule|
      WorkSchedule.find_or_create_by(work_schedule)
    end
  end

  private

  def process_schedule(schedule)
    day = schedule.day
    hours = (schedule.start_time...schedule.end_time).to_a
    hours.each do |hour|
      assign_hourly_work_schedule(day, hour)
    end
  end

  def assign_hourly_work_schedule(day, hour)
    available_engineers = available_engineers_for(day, hour)
    return if available_engineers.empty?

    least_assigned_engineer = find_least_assigned_engineer

    @assign_work_schedules << create_work_schedule(day, hour, least_assigned_engineer)
  end

  def available_engineers_for(day, hour)
    @engineer_availabilities.select { |availability| availability.day_of_week == day_number(day) && availability.hour == hour }
  end

  def find_least_assigned_engineer
    engineer_hours = @engineers.map do |engineer|
      [engineer, @assign_work_schedules.count { |work_schedule| work_schedule[:engineer_id] == engineer.id }]
    end.to_h

    engineer_hours.min_by { |_engineer, hours| hours }.first
  end

  def create_work_schedule(day, hour, engineer)
    {
      service_id: @service_id, engineer_id: engineer.id, year: @year,
      week: @week, day_of_week: day_number(day), hour:, assigned: true,
      work_date: Date.commercial(@year, @week, day_number(day))
    }
  end

  def day_number(day)
    day_map = {
      'monday' => 1, 'tuesday' => 2, 'wednesday' => 3, 'thursday' => 4,
      'friday' => 5, 'saturday' => 6, 'sunday' => 7
    }
    day_map[day.downcase]
  end
end
