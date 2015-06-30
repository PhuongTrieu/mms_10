class Admin::ProjectsController < ApplicationController
  before_action :admin_user

  def index
    @projects = Project.paginate page: params[:page],
                                 per_page: Settings.number_per_page
  end

  def show
    @project = Project.find params[:id]
    @leader = @project.leader
    @team = Team.find @project.team_id
    @project_users = @project.users.pluck :name, :id
  end

  def new
    @project = Project.new
    @teams = Team.all.pluck :name, :id
  end

  def create
    @project = Project.new project_params
    if @project.save
      flash[:success] = t "project.created"
      redirect_to admin_projects_path
    else
      render :new
    end
  end

  def edit
    @project = Project.find params[:id]
    @teams = Team.all.pluck :name, :id
  end

  def update
    @project = Project.find params[:id]
    if @project.update_attributes project_params
      redirect_to admin_project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = t "project.deleted"
    redirect_to admin_projects_path
  end

  private
  def project_params
    params.require(:project).permit :name, :abbreviation, :team_id,
                                    :leader_id,:start_date, :end_date,
                                    user_ids: []
  end
end
