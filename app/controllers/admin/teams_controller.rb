class Admin::TeamsController < ApplicationController
  before_action :admin_user

  def index
    @teams = Team.paginate page: params[:page],
                           per_page: Settings.number_per_page
  end

  def show
    @team = Team.find params[:id]
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
      flash[:success] = t "team.updated"
      respond_to do |format|
        format.html {redirect_to admin_team_path(@team)}
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    Team.find(params[:id]).destroy
    flash[:success] = t "team.deleted"
    redirect_to admin_teams_path
  end

  private
  def team_params
    params.require(:team).permit :name, :description, :team_id, user_ids: []
  end
end
