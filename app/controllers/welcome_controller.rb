class WelcomeController < ApplicationController

  def home
    if params[:screen_name].present?
      begin
        @user = User.find_or_create_by!(screen_name: params[:screen_name].downcase)
        @tweets = @client.user_timeline(@user.screen_name).take(10)

        if @tweets.empty?
          flash[:notice] = :screen_name, "Sorry, this user has no tweets."
        else
          if @user.last_tweet < @tweets.first.id
            @tweets.each do |tweet|
              next if tweet.id <= @user.last_tweet
              Tweet.create!(content: tweet.text, user: @user)
            end
            @user.update_attributes(last_tweet: @tweets.first.id)
          end
        end

        @user.update_photo @client.user(@user.screen_name).profile_image_url.path
      end

      true
    rescue Twitter::Error => e
      flash[:notice] = :screen_name, "Sorry, that user's tweets aren't available right now."

      false
    end
  end

end
