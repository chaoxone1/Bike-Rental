Rails.application.routes.draw do
  get 'dashboard/index'
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  devise_for :users
  root to: "bikes#index"
  resources :bikes do
    post 'book', on: :member
  end
  patch 'dashboard/accept_booking/:id', to: 'dashboard#accept_booking', as: 'accept_booking_dashboard'
  patch 'dashboard/decline_booking/:id', to: 'dashboard#decline_booking', as: 'decline_booking_dashboard'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :bikes
  resources :bookings
end
