class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :link
      t.string :vanity_link
      t.string :photo_url
      t.string :summary
      t.integer :user_id
      t.string :username
      t.integer :upvotes, :default => 0
      t.float :score, :default => 0
      t.boolean :current_user_voted # should always be nil in db

      t.timestamps null: false
    end
  end
end
