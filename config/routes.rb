Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/'

  resources :users, only: %i[index create show update]
  resources :negotiations, only: %i[index create show] do
    put :confirm, on: :member
    put :cancel, on: :member
  end
  resources :messages, only: %i[index]
  resources :deals, only: %i[index create show]
  resource :session, onle: [:create]
end
