# frozen_string_literal: true

Rails.application.routes.draw do
  resources :microposts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/:id', to: 'users#index'
  # get '/users', to: redirect('/1')
  get '/users' => redirect('/1')
  # rootをページ番号1にリダイレクトさせている
  root to: redirect('/1')
end
