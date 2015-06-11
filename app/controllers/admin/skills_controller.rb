class Admin::SkillsController < ApplicationController

  def index
    @skills = Skill.paginate page: params[:page], per_page:
    Settings.number_per_page
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new skill_params
    if @skill.save
      flash[:success] = t("skill.success")
      redirect_to admin_skills_path
    else
      render :new
    end
  end

  private
  def skill_params
    params.require(:skill).permit :name
  end
end
