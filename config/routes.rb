Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "home#index"


  
  #user paths
  get '/register', to: 'users#new', as: 'register'
  post '/register', to: 'users#create'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/users/:user_id/discover', to: 'movie#index', as: 'movie_index'
  get '/users/:user_id/movies', to: 'movie#results', as: 'movie_results'
  get '/users/:user_id/movies/:movie_id', to: 'movie#show', as: 'movie'
  get '/users/:user_id/movies/:movie_id/viewing_party/new', to: 'viewing_party#new', as: 'new_viewing_party'
  post '/users/:user_id/movies/:movie_id/viewing_party', to: 'viewing_party#create', as: 'viewing_party'
end