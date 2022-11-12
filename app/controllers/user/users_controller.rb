class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :search

  def search
    @q = User.ransack(params[:q])
  end

  def index
    @users = @q.result(distinct: true)
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :account_name, :email, :biography)
  end
end
