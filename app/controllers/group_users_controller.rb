class GroupUsersController < ApplicationController
  def create
    #binding.pry
    @group = Group.find(params[:format])
    join = GroupUser.new(group_id: @group.id, user_id: current_user.id)
    join.save
    # 非同期化
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @group = Group.find(params[:format])
    join = GroupUser.find_by(group_id: @group.id, user_id: current_user.id)
    join.destroy
    redirect_back(fallback_location: root_path)
  end

end
