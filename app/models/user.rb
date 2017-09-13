class User < ActiveRecord::Base
  has_many :tweets, dependent: :destroy

  validates_presence_of :screen_name
  validates_uniqueness_of :screen_name

  def update_photo image
    update_attributes(profile_url: "http://pbs.twimg.com" + image)
  end

  def get_tweets tweets
    begin
      tweets.each do |tweet|
        next if tweet.id <= last_tweet
        Tweet.create!(content: tweet.text, user: @user)
      end

      update_attributes(last_tweet: tweets.first.id)

      true
    rescue Twitter::Error => e
      flash[:notice] = :screen_name, "Sorry, that user's tweets aren't available right now."

      false
    end
  end
end
