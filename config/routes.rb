Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index new create show] do
      resources :comments, only: %i[create]
      resources :likes, only: %i[create]
    end
  end

  root 'users#index'
end
