class UsersController < ApplicationController
  def index
   @users = User.all
  end
  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
  end
  def edit
    @user = User.find(params[:id])
    if @user != current_user
      @books = current_user.books.page(params[:page]).reverse_order
      redirect_to user_path(current_user)
    end
  end
end
