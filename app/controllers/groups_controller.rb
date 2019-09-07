class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :join, :quit]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @groups=Group.all
  end

  def show
    @group=Group.find(params[:id])
    @posts=@group.posts.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
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
    if @group.update(group_params) #以畫面的值儲存
      redirect_to groups_path, notice: "Update success"
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    flash[:alert]="Group deleted"
    redirect_to groups_path
  end

  def join
    @group=Group.find(params[:id])
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice]="加入本討論板成功！"
    else
      flash[:warning]="你已經為本板成員！"
    end
    redirect_to group_path(@group)
  end

  def quit
    @group=Group.find(params[:id])
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert]="已退出本討論板！"
    else
      flash[:warning]="非本板成員！"
    end
    redirect_to group_path(@group)
  end

  private

  #取到畫面的值
  def  group_params
    params.require(:group).permit(:title, :description)
  end

  def find_group_and_check_permission
    @group=Group.find(params[:id]) #要修改的那筆
    if current_user!=@group.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

end
