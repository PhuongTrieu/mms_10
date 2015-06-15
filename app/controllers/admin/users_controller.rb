class Admin::UsersController < ApplicationController
  def index
    @users = User.paginate page: params[:page], 
                           per_page: Settings.number_per_page
  end
end
