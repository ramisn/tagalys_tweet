Rails.application.routes.draw do
  devise_for :users
  resources :twitter
  get '/tweets' => "twitter#tweets"
  get '/twitter_oauth_url' => 'twitter#generate_twitter_oauth_url'

  root :to => "twitter#index"
end
