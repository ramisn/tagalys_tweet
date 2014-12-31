class TwitterController < ApplicationController
	before_filter :authenticate_user!

	def index
		# unless TwitterOauthSetting.find_by_user_id(current_user.id).nil?
  #     redirect_to "/tweets"
  #   end
	end

	def generate_twitter_oauth_url
		oauth_callback = "http://#{request.host}:#{request.port}/tweets"
		@consumer = OAuth::Consumer.new("mU6uh3E6AkPxIEP1weAYklrmg","8JhsHFvirywD2rUkMJZofMv9b8Nb7oivzxvGIoKltaOtPWhJRd", :site => "https://api.twitter.com")
  	@request_token = @consumer.get_request_token(:oauth_callback => oauth_callback)
		session[:request_token] = @request_token
		redirect_to @request_token.authorize_url(:oauth_callback => oauth_callback)
		#redirect_to "/tweets"
	end

  def tweets
  	update_user_account()
    @user_timeline = get_client.user_timeline
    @home_timeline = get_client.home_timeline
    if params[:q]
    @search = get_client.search(params[:q], result_type: "recent").take(10)
	    @sea = @search.collect do |t|
	    	Tweet.create({
	    	user_name: t.user.screen_name,
	    	profile_img: t.user.profile_image_url,
	    	tweet: t.text,
	    	rt_count: t.retweet_count
	    	})
	    end
	  else
	  	@search = Tweet.order("rt_count desc").take(15)
    end
  end

	private

	def get_client
		client = Twitter::REST::Client.new do |config|
  		config.consumer_key = "mU6uh3E6AkPxIEP1weAYklrmg"
		  config.consumer_secret = "8JhsHFvirywD2rUkMJZofMv9b8Nb7oivzxvGIoKltaOtPWhJRd"
		  config.access_token        = "183871527-Nr4HSp0K381yBWcXdGOtl4qIGx4s5QVukHEE7KX6"
		  config.access_token_secret = "zlhfCB3kEClcGFCFmAlBuMFWHWBHKT7grgGpzhS5zfeKh"
		end
	end
	
	def update_user_account
	  user_twitter_profile = get_client.user
	  current_user.update_attributes({
	    name: user_twitter_profile.name, 
	    screen_name: user_twitter_profile.screen_name, 
	    url: user_twitter_profile.url, 
	    profile_image_url: user_twitter_profile.profile_image_url, 
	    location: user_twitter_profile.location, 
	    description: user_twitter_profile.description
	  })
	end
end
