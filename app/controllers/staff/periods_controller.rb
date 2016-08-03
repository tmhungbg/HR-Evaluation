class Staff::PeriodsController < AdminController
  def show
    @period = Period.find(params[:id]) 
  end

  def index
    @periods = Period.all.order(end_time: :DESC)
  end

  private
    def period_params
      params.require(:period).permit(:start_time, :end_time, :phase, staff_ids: [])
    end
end