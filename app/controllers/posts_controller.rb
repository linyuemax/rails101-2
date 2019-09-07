class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]

  def new
    #因為post由group衍生，所以須先知道為哪筆group衍生
    @group=Group.find(params[:group_id])
    @post=Post.new
  end

  def create
    @group=Group.find(params[:group_id])
    @post=Post.new(post_params) #new頁面使用者輸入的值帶入物件
    @post.group=@group
    @post.user=current_user
    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
