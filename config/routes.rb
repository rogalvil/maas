# frozen_string_literal: true

Rails.application.routes.draw do
  get 'confirmed_shifts', to: 'confirmed_shifts#index'

  root 'confirmed_shifts#index'
end
