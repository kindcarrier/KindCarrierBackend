Rails.application.routes.draw do
  root to: 'index#index'
  resources :users, only: %i[create show update]
  resource :session, onle: [:create]
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
