class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      if params[:flag] == Settings.done
        redirect_to @user
      else
        redirect_to user_add_skills_path(current_user)
      end
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :birthday, :email, :encrypted_password,
      skill_users_attributes: [:id, :level, :used_years, :_destroy],
      skill_ids: []
  end
end
