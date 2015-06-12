class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :kinja_id
      t.string :url
      t.string :name
      t.boolean :live

      t.timestamps null: false
    end
  end
end
