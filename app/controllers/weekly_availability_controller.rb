# frozen_string_literal: true

# Weekly Availability Controller
class WeeklyAvailabilityController < ApplicationController
  before_action :services, :engineers, :weeks, only: %i[index]

  def index; end

  private

  def services
    @services = Service.includes(:contract_schedules).all
  end

  def engineers
    @engineers = Engineer.all
  end

  def weeks
    current_date = Date.today
    @weeks = (0..5).map { |i| week_info(current_date + (i * 7)) }
  end

  def week_info(date)
    {
      label: "Semana #{date.cweek} del #{date.year}",
      value: date.cweek,
      start_date: date.beginning_of_week.strftime('%d/%m/%Y'),
      end_date: date.end_of_week.strftime('%d/%m/%Y')
    }
  end
end
