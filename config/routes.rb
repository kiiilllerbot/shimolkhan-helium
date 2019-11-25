Rails.application.routes.draw do

  match '/users', to: 'users#index', via: 'get'
  match '/users/:id', to: 'users#show', via: 'get'

  devise_for :users, :path_prefix => 'd'

  resources :users, :only =>[:show, :index]

  devise_scope :user do
    get 'd/users', to: 'devise/registrations#new'
    get 'd/users/password', to: 'devise/passwords#new'
  end

  resources :categories

  resources :posts do
    member do
      put "like", to: "posts#upvote"
      put "dislike", to: "posts#downvote"
    end
    resources :comments
  end

  root 'posts#index'
  
end
