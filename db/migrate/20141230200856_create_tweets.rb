class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :user_name
      t.string :profile_img
      t.string :tweet
      t.integer :rt_count

      t.timestamps
    end
  end
end
