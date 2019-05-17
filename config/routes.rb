# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[create show]
  resource :session, onle: [:create]
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
