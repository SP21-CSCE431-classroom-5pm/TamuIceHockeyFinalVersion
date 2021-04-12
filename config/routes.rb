Rails.application.routes.draw do

  root to: 'players#home'

  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

  resources :games do
    member do
      get :delete
    end
  end

  resources :players do
    member do
      get :delete
      get :home
    end
  end

 resources :participations do
    member do
      get :delete
      get :games
      get :playerParticipations
    end
  end 

  resources :analytics do
    member do
    end
  end

  
  
  get 'participations/new/:id/:player_id', to: 'participations#new' #this is incredibly janky, figure out how to do this not badly
  
  get '/help' => 'pages#help'
  get '/add_player' => 'pages#add_player'
  get '/login' => 'pages#login'
  get '/edit_player' => 'pages#edit_player'
  get '/delete_player' => 'pages#delete_player'
  get '/add_game' => 'pages#add_game'
  get '/edit_game' => 'pages#edit_game'
  get '/delete_game' => 'pages#delete_game'
  get '/view_game' => 'pages#view_game'
  
  get ':controller(/:action(/:id))'

  resources :players
  resources :games
  resources :participations
  resources :analytics
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end