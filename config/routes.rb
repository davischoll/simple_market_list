# frozen_string_literal: true

Rails.application.routes.draw do

  resources :market_lists do
    resources :market_list_items
  end

  root to: 'market_lists#index'
end
