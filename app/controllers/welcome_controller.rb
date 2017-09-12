class WelcomeController < ApplicationController
  def home
    if params[:screen_name].present?
      @user = User.find_or_create_by!(screen_name: params[:screen_name].downcase)
      @tweets = @client.user_timeline(@user.screen_name).take(10)
      if @user.last_tweet < @tweets.first.id
        @tweets.each do |tweet|
          next if tweet.id <= @user.last_tweet
          Tweet.create!(content: tweet.text, user: @user)
        end
        @user.update_attributes(last_tweet: @tweets.first.id)
      end
    end
  end
end
