Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'work_orders#index'
  # get 'work_orders/index'
  # resources :time_slots, only: [ :index ] do
    resources :work_orders, only: [ :index ]
  # end
end
