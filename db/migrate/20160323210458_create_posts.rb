class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :link
      t.string :vanity_link
      t.string :photo_url
      t.string :summary
      t.integer :user_id
      t.integer :upvotes
      t.integer :score

      t.timestamps null: false
    end
  end
end
