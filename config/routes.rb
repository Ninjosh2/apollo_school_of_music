Rails.application.routes.draw do
  resources :lessons
  resources :teachers do
    resources :lessons, only: [:index, :new]
  end
  resources :students do
    resources :teachers, only: [:index]
    resources :lessons, only: [:index, :new]
  end
  devise_for :users
  root 'students#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
