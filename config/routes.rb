# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # namespace the controllers without affecting the URI

  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :users
    resources :appointments
    resources :categories
    resources :doctors
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
