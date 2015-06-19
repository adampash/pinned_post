class AddSiteToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :site, :string
  end
end
