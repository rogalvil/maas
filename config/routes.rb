# frozen_string_literal: true

Rails.application.routes.draw do
  get 'confirmed_shifts', to: 'schedules#confirmed_shifts'
  get 'weekly_availabilities', to: 'schedules#weekly_availabilities'

  root 'schedules#confirmed_shifts'
end
