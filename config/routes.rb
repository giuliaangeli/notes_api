Rails.application.routes.draw do
  root "notes#index"
  resources :notes

  namespace :api do
    resources :notes, only: [:index, :show, :create, :update, :destroy]
  end
end
