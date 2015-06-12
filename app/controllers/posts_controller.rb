class PostsController < ApplicationController
  def index
    @posts = Post.all.order('created_at DESC')
  end

  def create
    @post = Post.create_from_params params
    render json: @post
  end

  def update
    @post = Post.find params[:id]
    @post.update_attributes live: params[:live]
    Post.delay.run_update(@post.id)
    render json: @post
  end
end
