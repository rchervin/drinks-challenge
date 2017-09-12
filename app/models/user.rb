class User < ActiveRecord::Base
  has_many :tweets, dependent: :destroy

  validates_presence_of :screen_name
  validates_uniqueness_of :screen_name

  def update_photo image
    update_attributes(profile_url: "http://pbs.twimg.com" + image)
  end
end
