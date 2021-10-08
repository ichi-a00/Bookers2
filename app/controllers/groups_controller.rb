class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path(), notice: "You have created group successfully."
    else
      render :new
    end
  end

  def index
    @groups = Group.all
    #.page(params[:page]).reverse_order
  end

  def show
    @group = Group.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @group = Group.find(params[:id])
    if @group.owner_id != current_user.id
      #@books = current_user.books.page(params[:page]).reverse_order
      @groups = Group.all
      redirect_to groups_path()
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group.id), notice: "You have updated group successfully."
    else
      render :edit
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path, alert: "You have destroyed grup@ successfully"
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end
