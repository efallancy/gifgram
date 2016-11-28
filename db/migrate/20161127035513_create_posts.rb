class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :caption
      t.text :post_gif
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
