Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :movies
  root :to => redirect('/movies')

  get  'auth/:provider/callback', to: 'sessions#create'
  get 'auth/:provider'        => 'sessions#loginbefore'
  post 'logout' => 'sessions#destroy'
  get  'auth/failure' => 'sessions#failure'
  get  'auth/twitter' => 'login_twitter'

end
