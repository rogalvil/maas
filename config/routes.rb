# frozen_string_literal: true

Rails.application.routes.draw do
  get 'weekly_availability', to: 'weekly_availability#index'

  root 'weekly_availability#index'
end
