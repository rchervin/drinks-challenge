class WelcomeController < ApplicationController
  def home
    if params[:screen_name]
      @account = params[:screen_name].downcase
      @user = User.find_or_create_by!(screen_name: @account)
      @responses = @client.user_timeline(@user.screen_name).take(10)
    end
  end
end
