Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "home#index"


  
  #user paths
  get '/register', to: 'user#new', as: 'new_user'
  post '/register', to: 'user#create'
  get '/login_form', to: 'user#login_form', as: 'login_form'
  post '/login', to: 'user#login', as: 'login'
  get 'logout', to: 'user#logout', as: 'logout'
  get '/users/:user_id/discover', to: 'movie#index', as: 'movie_index'
  get '/users/:user_id/movies', to: 'movie#results', as: 'movie_results'
  get '/users/:user_id/movies/:movie_id', to: 'movie#show', as: 'movie'
  get '/users/:user_id/movies/:movie_id/viewing_party/new', to: 'viewing_party#new', as: 'new_viewing_party'
  get '/users/:id', to: 'user#show', as: 'user'
end