class User < ActiveRecord::Base
  has_many :tweets, dependent: :destroy

  validates_presence_of :screen_name
  validates_uniqueness_of :screen_name

  def self.get_tweets
    @client.user_timeline(screen_name).take(10)
  end
end
