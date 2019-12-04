Rails.application.routes.draw do
  resources :issues
  resources :users
  resources :issues do
    resources :comments
    member do
      put :like, to:'issues#upvote'
      put :dislike, to:'issues#downvote'
      put :watch, to:'issues#watch'
      put :unwatch, to:'issues#unwatch'
    end
  end
  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'home', to: 'home#show'
  get 'me', to: 'issues#index', as: 'me'
  

get '/issues/:id/file' => "issues#show_attachment"
post '/issues/:id/attachment' => "issues#create_attachment"
  
  root to: "home#show"

end