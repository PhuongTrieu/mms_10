class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      redirect_to @user
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :birthday, :email,:encrypted_password,
                                 skill_ids: []
  end
end
