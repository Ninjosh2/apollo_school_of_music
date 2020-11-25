Rails.application.routes.draw do
  resources :lessons

  get '/teachers/sort', to: 'teachers#sort'
  
  resources :teachers do
    resources :lessons, only: [:index, :new]
  end

  get '/students/sort', to: 'students#sort'
  
  resources :students do
    resources :teachers, only: [:index]
    resources :lessons, only: [:index, :new]
  end


  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_scope :users do
  #   get 'users/sign_in', to: 'users/sessions#new', as: :new_users_session
  #   get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_users_session
  # end
  root 'students#index'
end
