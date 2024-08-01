# frozen_string_literal: true

Rails.application.routes.draw do
  get 'confirmed_shifts', to: 'schedules#confirmed_shifts'

  root 'schedules#confirmed_shifts'
end
