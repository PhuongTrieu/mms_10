class Admin::TeamsController < ApplicationController
  before_action :admin_user

  def index
    @teams = Team.paginate page: params[:page],
                           per_page: Settings.number_per_page
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new team_params
    if @team.save
      flash[:succes] = t "team.created"
      redirect_to admin_teams_path
    else
      render :new
    end
  end

  private
  def team_params
    params.require(:team).permit :name, :description
  end
end
