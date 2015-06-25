class Admin::SkillsController < ApplicationController
  before_action :admin_user

  def index
    @skills = Skill.paginate page: params[:page],
                             per_page: Settings.number_per_page
    respond_to do |format|
      format.html
      format.csv {send_data @skills.to_csv}
    end
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new skill_params
    if @skill.save
      flash[:success] = t "skill.created"
      redirect_to admin_skills_path
    else
      render :new
    end
  end

  def edit
    @skill = Skill.find params[:id]
  end

  def update
    @skill = Skill.find params[:id]
    if @skill.update_attributes skill_params
      flash[:success] = t "skill.updated"
      redirect_to admin_skills_path
    else
      render :edit
    end
  end

  def destroy
    Skill.find(params[:id]).destroy
    flash[:success] = t "skill.deleted"
    redirect_to admin_skills_path
  end

  private
  def skill_params
    params.require(:skill).permit :name
  end
end
