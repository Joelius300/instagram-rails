Rails.application.routes.draw do
  get 'users/show'
  root 'pages#home'
  devise_for :users, controllers: {registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show]

  resources :posts, only: [:index, :show, :create, :destroy] do
    resources :photos, only: [:create]
  end
end
