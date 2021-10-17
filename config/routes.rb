# frozen_string_literal: true

Rails.application.routes.draw do
  resources :market_lists
  root to: 'market_lists#index'
end
