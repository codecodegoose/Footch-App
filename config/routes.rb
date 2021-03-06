Rails.application.routes.draw do

  
  devise_for :users
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  unauthenticated do
    root to: "pages#home"
  end
  authenticated :user do
    root 'user_queries#new', as: :authenticated_root
  end
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [ :show ]
  resources :user_queries, only: [ :new, :create, :show, :index ]

  resources :recipes, only: [ :show, :new, :create ] do
    resources :cookbooks, only: [ :create ]
    resources :user
  end
  resources :cookbooks, only: [ :index, :destroy ]

  resources :parties, only: [ :index, :new, :create, :show, :destroy ] do
    resources :user_parties, only: [:create, :update]
    resources :party_recipes, only: [ :create, :update ]
    resources :messages, only: [:create]

  end
    post 'voting', to: 'party_recipes#voting'

    resources :user_parties, only: [] do
    resources :party_ingredients, only: [ :new, :create ]
  end
  resources :party_ingredients, only: [ :destroy ]
  resources :party_recipes, only: [ :destroy ]
  resources :pages
  get 'dashboard', to: 'pages#dashboard'
  
end
 