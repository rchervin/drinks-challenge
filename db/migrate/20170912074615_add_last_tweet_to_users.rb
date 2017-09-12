class AddLastTweetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_tweet, :integer, default: 0, limit: 8
  end
end
