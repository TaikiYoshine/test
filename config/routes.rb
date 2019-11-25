# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users do
    resources :favfoods
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/:id', to: 'users#index'
  # get '/users', to: redirect('/1')
  get '/users' => redirect('/1')
  # rootをページ番号1にリダイレクトさせている
  root to: redirect('/1')

  get '/api/v1/users', to: 'api/users#index'
  get '/api/v1/users/:id', to: 'api/users#show'
  post '/api/v1/users', to: 'api/users#create'
  put '/api/v1/users/:id', to: 'api/users#update'
  delete '/api/v1/users/:id', to: 'api/users#destroy'
end
