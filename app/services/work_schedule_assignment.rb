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

    available_engineers.each do |engineer|
      assign_consecutive_hours(day, hours, engineer)
    end
  end

  def assign_consecutive_hours(day, hours, engineer)
    hours.each do |hour|
      next if already_assigned?(day, hour)

      @assign_work_schedules << create_work_schedule(day, hour, engineer)
    end
  end

  def available_engineers_for_day(day)
    @engineer_availabilities.select { |availability| availability.day_of_week == day_number(day) }.map(&:engineer).uniq
  end

  def already_assigned?(day, hour)
    @assign_work_schedules.any? { |schedule| schedule[:day_of_week] == day_number(day) && schedule[:hour] == hour }
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
