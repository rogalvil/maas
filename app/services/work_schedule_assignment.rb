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
    available_engineers = available_engineers_for_day(day)

    assign_least_hours_engineers(day, hours, available_engineers, 2)
    assign_remaining_hours(day, hours, available_engineers)
  end

  def assign_least_hours_engineers(day, hours, available_engineers, minimum_engineers)
    minimum_engineers.times do
      engineer = find_least_assigned_engineer(available_engineers, day, hours)
      assign_consecutive_hours(day, hours, engineer) if engineer
      available_engineers.delete(engineer)
    end
  end

  def assign_remaining_hours(day, hours, available_engineers)
    while hours.any? && available_engineers.any?
      engineer = find_least_assigned_engineer(available_engineers, day, hours)
      assign_consecutive_hours(day, hours, engineer) if engineer
      available_engineers.delete(engineer)
    end
  end

  def assign_consecutive_hours(day, hours, engineer)
    assigned_hours = []
    hours.each do |hour|
      next if already_assigned?(day, hour)
      next unless available?(engineer, day, hour)

      @assign_work_schedules << create_work_schedule(day, hour, engineer)
      assigned_hours << hour
    end
    hours.reject! { |hour| assigned_hours.include?(hour) }
  end

  def available_engineers_for_day(day)
    @engineer_availabilities.select { |availability| availability.day_of_week == day_number(day) }.map(&:engineer).uniq
  end

  def already_assigned?(day, hour)
    @assign_work_schedules.any? { |schedule| schedule[:day_of_week] == day_number(day) && schedule[:hour] == hour }
  end

  def find_least_assigned_engineer(engineers, day, hours)
    engineer_hours = engineers.map do |engineer|
      [engineer, count_assigned_hours(engineer, day, hours)]
    end.to_h

    engineer_hours.min_by { |_engineer, h| h }&.first
  end

  def count_assigned_hours(engineer, day, hours)
    max_hours = 8
    assigned_hours = @assign_work_schedules.count { |schedule| schedule[:engineer_id] == engineer.id }
    available_hours = hours.count { |hour| available?(engineer, day, hour) }
    penalty = [0, max_hours - available_hours].max
    assigned_hours + penalty
  end

  def available?(engineer, day, hour)
    @engineer_availabilities.any? do |availability|
      availability.engineer_id == engineer.id &&
        availability.day_of_week == day_number(day) &&
        availability.hour == hour
    end
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
