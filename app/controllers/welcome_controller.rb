class WelcomeController < ApplicationController
  before_action :clear_flash
  before_action :set_screen_name

  def home
    begin
    @user = User.find_or_create_by!(screen_name: params[:screen_name].downcase)
    @tweets = @client.user_timeline(@user.screen_name).take(10)

    if @tweets.present?
      @user.get_tweets   @tweets
      @user.update_photo @twitter_user.profile_image_url.path
    else
      flash[:notice] = :screen_name, "Sorry, @#{@user.screen_name} has no tweets."
    end

    rescue Twitter::Error => e
      flash[:notice] = :screen_name, "Unable to reach tweets for @#{@user.screen_name}."
    end
  end

  private

  def clear_flash
    flash[:notice] = ""
  end

  def set_screen_name
    begin
      params[:screen_name] ||= "just_drinks"
      @twitter_user = @client.user(@screen_name)
    rescue Twitter::Error => e
      flash[:notice] = :screen_name, "@#{@screen_name} does not seem to have a twitter account."
    end
  end

end
