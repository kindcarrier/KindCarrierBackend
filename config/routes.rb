Rails.application.routes.draw do
  root to: 'index#index'
  resources :users, only: %i[index create show update]
  resources :negotiations, only: %i[index create show] do
    put :confirm, on: :member
    put :cancel, on: :member
  end
  resources :deals, only: %i[index create show]
  resource :session, onle: [:create]
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
