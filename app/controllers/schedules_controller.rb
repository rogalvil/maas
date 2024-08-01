# frozen_string_literal: true

# Schedules Controller
class SchedulesController < ApplicationController
  before_action :defaults, only: %i[confirmed_shifts weekly_availabilities]
  before_action :services, :weeks, :engineers, :contract_schedule, only: %i[confirmed_shifts weekly_availabilities]
  before_action :work_schedules, only: %i[confirmed_shifts]
  before_action :engineer_availabilities, only: %i[weekly_availabilities]

  def confirmed_shifts; end

  def weekly_availabilities; end

  private

  def defaults
    @selected_service_id = params[:service_id] || Service.first&.id
    @selected_week = (params[:week] || Date.today.cweek).to_i
    @selected_year = (params[:year] || Date.today.year).to_i
  end

  def services
    @services = Service.includes(:contract_schedules).all
  end

  def engineers
    @engineers = Engineer.all
  end

  def contract_schedule
    @contract_schedule = ContractSchedule.where(service_id: @selected_service_id)
  end

  def engineer_availabilities
    @engineer_availabilities = EngineerAvailability.where(
      service_id: @selected_service_id, week: @selected_week, year: @selected_year
    ).includes(:engineer).map do |schedule|
      format_schedule(schedule)
    end
  end

  def work_schedules
    @work_schedules = WorkSchedule.where(
      service_id: @selected_service_id,
      work_date: selected_date_range
    ).includes(:engineer).map { |schedule| format_schedule(schedule) }
  end

  def selected_date_range
    start_date = Date.commercial(@selected_year, @selected_week, 1)
    end_date = Date.commercial(@selected_year, @selected_week, 7)
    start_date..end_date
  end

  def format_schedule(schedule)
    {
      year: schedule.year, week: schedule.week, hour: schedule.hour,
      day_of_week_name: day_name(schedule.year, schedule.week, schedule.day_of_week),
      engineer: schedule.engineer.name, color: schedule.engineer.color
    }
  end

  def day_name(year, week, day)
    p year, week, day
    Date.commercial(year, week, day).strftime('%A').downcase
  end

  def weeks
    current_date = Date.today
    past_weeks = past_work_schedules_weeks
    future_weeks = (0..5).map { |i| week_info(current_date + (i * 7)) }
    @weeks = (past_weeks + future_weeks).uniq.sort_by { |week| [week[:year], week[:value]] }
  end

  def past_work_schedules_weeks
    WorkSchedule.distinct.pluck(:year, :week).map do |year, week|
      date = Date.commercial(year, week, 1)
      week_info(date)
    end
  end

  def week_info(date)
    {
      label: "Semana #{date.cweek} del #{date.year}",
      value: date.cweek,
      year: date.year,
      start_date: date.beginning_of_week.strftime('%d/%m/%Y'),
      end_date: date.end_of_week.strftime('%d/%m/%Y')
    }
  end
end
