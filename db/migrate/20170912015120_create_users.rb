class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :screen_name

      t.timestamps null: false
    end
  end
end
