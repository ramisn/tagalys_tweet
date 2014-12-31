Rails.application.routes.draw do
  devise_for :users
  resources :twitter
  root :to => "twitter#index"
  get '/twitter_oauth_url' => 'twitter#generate_twitter_oauth_url'
  get '/callback' => 'twitter#callback'
  get '/tweets' => "twitter#tweets"
end
