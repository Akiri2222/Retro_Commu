class User::UsersController < ApplicationController
  before_action :authenticate_user!


  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def book_marks
    @user = User.find(params[:id])
    book_marks = BookMark.where(user_id: @user.id).pluck(:post_id)
    @book_mark_posts = Post.find(book_marks)
  end

  private

  def user_params
    params.require(:user).permit(:name, :account_name, :email, :biography)
  end


end
