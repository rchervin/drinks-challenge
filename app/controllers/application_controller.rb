require 'twitter'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_twitter_client

  private

  def set_twitter_client
    def client
    Twitter.configure do |config|
      config.consumer_key = TwitterToken.consumer.key
      config.consumer_secret = TwitterToken.consumer.secret
      config.oauth_token = token
      config.oauth_token_secret = secret
    end
    @client ||= Twitter::Client.new
  end
    # @client = Twitter::REST::Client.new do |config|
    #   config.consumer_key            = ENV["DC_TWITTER_CONSUMER_KEY"]
    #   config.consumer_secret         = ENV["DC_TWITTER_SECRET_KEY"]
    #   config.access_token            = ENV["DC_TWITTER_ACCESS_TOKEN"]
    #   config.access_token_secret     = ENV["DC_TWITTER_ACCESS_TOKEN_SECRET"]
    # end
    # string = "#{ENV['DC_TWITTER_CONSUMER_KEY']}:#{ENV['DC_TWITTER_SECRET_KEY']}"
    # encoded_data = Base64.decode64(string)
    consumer = OAuth::Consumer.new(ENV['DC_TWITTER_CONSUMER_KEY'], ENV['DC_TWITTER_SECRET_KEY'], :site => "http://api.twitter.com", :scheme => :header)
    @access_token = OAuth::AccessToken.from_hash(consumer, :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret)
  end
end
