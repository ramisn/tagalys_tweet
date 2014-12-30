Rails.application.routes.draw do
  devise_for :users
  resources :twitter
  get '/tweets' => "twitter#tweets"
  #get '/oauth_account' => "twitter#oauth_account"
  get '/twitter_oauth_url' => 'twitter#generate_twitter_oauth_url'

  root :to => "twitter#index"
end
