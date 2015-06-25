class Admin::PositionsController < ApplicationController
  before_action :admin_user

  def index
    @positions = Position.paginate page: params[:page],
                                   per_page: Settings.number_per_page
    respond_to do |format|
      format.html
      format.csv {send_data @positions.to_csv}
    end
  end

  def new
    @position = Position.new
  end

  def create
    @position = Position.new position_params
    if @position.save
      flash[:success] = t "position.created"
      redirect_to admin_positions_path
    else
      render :new
    end
  end

  def destroy
    Position.find(params[:id]).destroy
    flash[:success] = t "position.deleted"
    redirect_to admin_positions_path
  end

  private
  def position_params
    params.require(:position).permit :name, :abbreviation
  end
end
