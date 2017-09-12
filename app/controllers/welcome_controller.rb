class WelcomeController < ApplicationController
  def home
    if params[:screen_name].present?
      @user = User.find_or_create_by!(screen_name: params[:screen_name].downcase)
      @tweets = @client.user_timeline(@user.screen_name).take(10)
    end
  end
end
