class Admin::ProjectsController < ApplicationController
  before_action :admin_user

  def index
    @projects = Project.paginate page: params[:page],
                                 per_page: Settings.number_per_page
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

  private
  def project_params
    params.require(:project).permit :name, :abbreviation, :team_id,
                                    :start_date, :end_date
  end
end
