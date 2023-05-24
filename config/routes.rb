Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  root "home#index"
  
  
  
  #user paths
  get '/register', to: 'user#new', as: 'new_user'
  post '/register', to: 'user#create'
  get '/dashboard', to: 'user#show', as: 'user'
  post '/login', to: 'user#login', as: 'login'
  get 'logout', to: 'user#logout', as: 'logout'
  get '/login_form', to: 'user#login_form', as: 'login_form'
  
  #movie paths
  get '/discover', to: 'movie#index', as: 'movie_index'
  get '/movies', to: 'movie#results', as: 'movie_results'
  get '/movies/:movie_id', to: 'movie#show', as: 'movie'
  
  #viewing party paths
  get '/viewing_party/new', to: 'viewing_party#new', as: 'new_viewing_party'

  #admin paths
  get '/admin/dashboard', to: 'admin#dashboard', as: 'admin_dashboard'
  get '/admin/users/:id', to: 'admin#user_show', as: 'admin_user_show'
end