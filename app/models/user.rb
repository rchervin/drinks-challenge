class User < ActiveRecord::Base
  validates_presence_of :screen_name
  validates_uniqueness_of :screen_name
  def get_all_tweets
    # collect_with_max_id do |max_id|
      options = {count: 10, include_rts: true}
      user_timeline(user, options)
    # end
  end
end
