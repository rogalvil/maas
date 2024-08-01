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

  private

  def create_engineer_availability
    p "create"
    @engineer_availability = EngineerAvailability.new(engineer_availability_params)
    p @engineer_availability.inspect
    if @engineer_availability.save
      render json: { success: true, engineer_availability: @engineer_availability }
    else
      render json: { success: false, errors: @engineer_availability.errors.full_messages }
    end
  end

  def destroy_engineer_availability
    @engineer_availability = EngineerAvailability.find_by(engineer_availability_params)
    p @engineer_availability.inspect
    if @engineer_availability.destroy
      render json: { success: true }
    else
      render json: { success: false, errors: @engineer_availability.errors.full_messages }
    end
  end

  # def engineer_availability
  #   p "params: #{params}"
  #   # @engineer_availability = EngineerAvailability.find(params[:id])
  #   @engineer_availability = EngineerAvailability.find_by(engineer_availability_params)
  #   p @engineer_availability.inspect
  # end

  def engineer_availability_params
    params.require(:engineer_availability).permit(:service_id, :engineer_id, :year, :week, :day_of_week, :hour)
  end
end
