class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @users = User.paginate page: params[:page],
                           per_page: Settings.number_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "user.created"
      redirect_to admin_root_path
    else
      flash[:danger] = t "user.create_fail"
      render :new
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    flash[:success] = t "user.deleted"
    redirect_to admin_root_path
  end

  private
  def user_params
    params.require(:user).permit :name, :birthday, :email, :password, :is_admin
  end
end
