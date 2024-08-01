# frozen_string_literal: true

Rails.application.routes.draw do
  get 'confirmed_shifts', to: 'schedules#confirmed_shifts'
  get 'weekly_availabilities', to: 'schedules#weekly_availabilities'

  resources :engineer_availabilities, only: [] do
    collection do
      post :toggle
    end
  end

  root 'schedules#confirmed_shifts'
end
