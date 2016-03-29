class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :id_token
      t.string :uid, null: false
      t.string :name
      t.string :location
      t.string :email
      t.string :image_url
      t.string :email
      t.string :gender
      t.string :url
      t.string :username

      # add_index :users, :provider
      # add_index :users, :uid
      # add_index :users, [:provider, :uid], unique: true

      t.timestamps null: false
    end
  end
end
