class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    ff = Relationship.new(follower_id: current_user.id, followed_id: user.id)
    #binding.pry
    ff.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = User.find(params[:user_id])
    ff = current_user.follower.find_by(followed_id: user.id)
    binding.pry
    ff.destroy
    redirect_back(fallback_location: root_path)
  end
end
