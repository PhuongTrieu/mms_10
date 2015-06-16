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

  def edit
    @team = Team.find params[:id]
  end

  def update
    @team = Team.find params[:id]
    if @team.update_attributes team_params
      flash[:succes] = t "team.updated"
      redirect_to admin_teams_path
    else
      render :edit
    end
  end

  def destroy
    Team.find(params[:id]).destroy
    flash[:succes] = t "team.deleted"
    redirect_to admin_teams_path
  end

  private
  def team_params
    params.require(:team).permit :name, :description
  end
end
