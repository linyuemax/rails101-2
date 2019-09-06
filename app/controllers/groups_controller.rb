class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

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
    @group.user=current_user
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    @group=Group.find(params[:id]) #要修改的那筆
    if @group.update(group_params) #以畫面的值儲存
      redirect_to groups_path, notice: "Update success"
    else
      render :edit
    end
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
