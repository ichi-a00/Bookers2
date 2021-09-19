class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    ff = Relationship.new(follower_id: current_user.id, followed_id: user.id)
    #binding.pry
    ff.save
    redirect_back(fallback_location: root_path)
  end

  def follows
    @user = User.find(params[:user_id])
    @books = @user.books.page(params[:page]).reverse_order
    @follows_user = @user.follows
  end

  def followers
    @user = User.find(params[:user_id])
    @books = @user.books.page(params[:page]).reverse_order
    @followers_user = @user.followers
  end

  def destroy
    user = User.find(params[:user_id])
    ff = current_user.follower.find_by(followed_id: user.id)
    #binding.pry
    ff.destroy
    redirect_back(fallback_location: root_path)
  end
end
