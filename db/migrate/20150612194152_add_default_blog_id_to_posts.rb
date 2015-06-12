class AddDefaultBlogIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :default_blog_id, :integer
  end
end
