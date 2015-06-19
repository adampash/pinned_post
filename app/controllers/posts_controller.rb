class PostsController < ApplicationController
  def index
    if current_user.admin? or current_user.site == params[:site]
      @posts = Post.all.order('created_at DESC').where(site: params[:site])
    else
      redirect_to "/#{current_user.site}"
    end
  end

  def create
    if current_user.admin? or current_user.site == params[:site]
      @post = Post.create_from_params params, current_user
      render json: @post
    else
      render status: 500
    end
  end

  def update
    @post = Post.find params[:id]
    @post.update_attributes live: params[:live]
    Post.delay.run_update(@post.id)
    render json: @post
  end

  def destroy
    @post = Post.find params[:id]
    if current_user.site == @post.site or current_user.admin?
      @post.destroy
      render nothing: true
    else
      render status: 500
    end
  end

end
