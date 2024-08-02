# frozen_string_literal: true

# Engineer Availabilities Controller
class EngineerAvailabilitiesController < ApplicationController
  def toggle
    if params[:available] == 'create'
      create_engineer_availability
    else
      destroy_engineer_availability
    end
  end

  def assignment
    service_id = params[:service_id]
    year = params[:year]
    week = params[:week]
    work_schedule_assignment = WorkScheduleAssignment.new(service_id, year, week)
    work_schedule_assignment.assign_work_schedules
    work_schedule_assignment.save_work_schedules
    render json: { message: 'Turnos asignados exitosamente' }
  rescue StandardError => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  private

  def create_engineer_availability
    @engineer_availability = EngineerAvailability.new(engineer_availability_params)
    if @engineer_availability.save
      render json: { engineer_availability: @engineer_availability }
    else
      render json: { errors: @engineer_availability.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy_engineer_availability
    @engineer_availability = EngineerAvailability.find_by(engineer_availability_params)
    if @engineer_availability.destroy
      render json: { message: 'Eliminado exitosamente' }
    else
      render json: { errors: @engineer_availability.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def engineer_availability_params
    params.require(:engineer_availability).permit(:service_id, :engineer_id, :year, :week, :day_of_week, :hour)
  end
end
