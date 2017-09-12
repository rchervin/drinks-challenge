class WelcomeController < ApplicationController
  def home
    if params[:screen_name].present?
      @user = User.find_or_create_by!(screen_name: params[:screen_name].downcase)
      @tweets = @client.user_timeline(@user.screen_name).take(10)
      @response = @access_token.get("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=chervillain&count=2")
      logger.info @response.inspect
    end
  end
end
