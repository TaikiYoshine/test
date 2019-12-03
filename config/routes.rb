# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users do
    resources :favfoods
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/:id', to: 'users#index'
  # get '/users', to: redirect('/1')
  get '/1', to: 'users#index', as: :index
  get '/users' => redirect('/1')
  # rootをページ番号1にリダイレクトさせている
  root to: redirect('/1')

  namespace :api do
    scope '/v1' do
      resources :users
    end
  end
end
