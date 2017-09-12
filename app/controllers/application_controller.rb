class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_twitter_client

  private

  def set_twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["DC_TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["DC_TWITTER_SECRET_KEY"]
    end
  end
end
