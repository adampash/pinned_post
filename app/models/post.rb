require 'updater'

class Post < ActiveRecord::Base
  validates :kinja_id, uniqueness: true

  def self.create_from_params(options)
    post = Kinja.new.get_post(options[:url])
    url = post["data"]["permalink"]
    kinja_id = post["data"]["id"]
    default_blog_id = post["data"]["defaultBlogId"]
    name = options[:description] or post["data"]["headline"]
    create(
      url: url,
      name: name,
      kinja_id: kinja_id,
      live: false,
      default_blog_id: default_blog_id,
    )
  end

  def self.run_update(id)
    post = Post.find(id)
    if post.live?
      Updater.run post.url, post.default_blog_id
      Post.delay_for(1.minute).run_update(id)
    end
  end

end
