Rails.application.routes.draw do
  resources :lessons
  resources :teachers do
    resources :lessons, only: [:index, :new]
  end
  resources :students do
    resources :teachers, only: [:index]
    resources :lessons, only: [:index, :new]
  end

  root 'students#index'
end
