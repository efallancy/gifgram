class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :username
      t.text :name
      t.text :email
      t.text :profile_img
      t.text :biography
      t.text :password_digest

      t.timestamps null: false
    end
  end
end
