# frozen_string_literal: true

# Weekly Availability Controller
class WeeklyAvailabilityController < ApplicationController
  before_action :defaults, only: %i[index]
  before_action :services, :engineers, :weeks, :work_schedules, only: %i[index]

  def index; end

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

  def work_schedules
    p @selected_year
    p @selected_week
    start_date = Date.commercial(@selected_year, @selected_week, 1)
    end_date = Date.commercial(@selected_year, @selected_week, 7)

    @work_schedules = WorkSchedule.where(
      service_id: @selected_service_id,
      work_date: start_date..end_date
    ).includes(:engineer).map do |schedule|
      {
        id: schedule.id,
        year: schedule.year,
        week: schedule.week,
        day_of_week: schedule.day_of_week,
        day_of_week_name: day_name(schedule.week, schedule.day_of_week),
        hour: schedule.hour,
        assigned: schedule.assigned,
        work_date: schedule.work_date,
        engineer: schedule.engineer.name,
        color: schedule.engineer.color
      }
    end
  end

  def day_name(week, day)
    Date.commercial(Date.today.year, week, day).strftime('%A').downcase
  end

  def weeks
    current_date = Date.today
    @weeks = (0..160).map { |i| week_info(current_date + (i * 7)) }
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
