class GroupsController < ApplicationController
  def index
    @groups=Group.all
  end

  def show
    @group=Group.find(params[:id])
  end

  def edit
    @group=Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params) #直接存入的那筆
    @group.save
    redirect_to groups_path
  end

  def update
    @group=Group.find(params[:id]) #要修改的那筆
    @group.update(group_params) #以畫面的值儲存
    redirect_to groups_path, notice: "Update success"
  end

  def destroy
    @group=Group.find(params[:id])
    @group.destroy
    flash[:alert]="Group deleted"
    redirect_to groups_path
  end

  private

  #取到畫面的值
  def  group_params
    params.require(:group).permit(:title, :description)
  end

end
