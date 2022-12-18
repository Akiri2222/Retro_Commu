class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all
    @genres = Genre.all
    @tags=Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    @tags = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      @post.update_tags(tags)
      redirect_to admin_post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.update_tags([])
    @post.destroy
    redirect_to admin_posts_path
  end


  private

  def post_params
    params.require(:post).permit(:genre_id, :user_id, :title, :text)
  end

end
