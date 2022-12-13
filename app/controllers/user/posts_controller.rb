class User::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:create, :edit, :update, :destroy]
  before_action :ensure_current_user, {only: [:edit, :update]}

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tags = params[:post][:name].split(',')
    if @post.save
      @post.save_tags(tags)
      redirect_to posts_path
    else
      render :new
    end
  end

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
    tags = params[:post][:name].split(',')
    if @post.update(post_params)
      @post.update_tags(tags)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.update_tags([])
    @post.destroy
    redirect_to posts_path
  end


  private

  def post_params
    params.require(:post).permit(:genre_id, :user_id, :title, :text)
  end

  def ensure_current_user
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      flash[:notice]="権限がありません"
      redirect_to("/posts")
    end
  end

end
