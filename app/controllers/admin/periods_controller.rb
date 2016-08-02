class Admin::PeriodsController < AdminController
  def new
    @period = Period.new
    @period.staff_ids = Staff.active.pluck(:id)
  end

  def show
    @period = Period.find(params[:id]) 
  end

  def index
    @periods = Period.all.order(end_time: :DESC)
  end

  def create
    @period = Period.new(period_params)
    if @period.save
      redirect_to admin_periods_path
    else
      render 'new'
    end
  end
 
  def edit
    @period = Period.find(params[:id])
    flash[:notice] = "This period is outdate."
    redirect_to admin_periods_path if @period.outdate?
  end

  def update
    @period = Period.find(params[:id])
    flash[:notice] = "This period is outdate."
    redirect_to admin_periods_path if @period.outdate?
    if @period.update(period_params)
      redirect_to admin_periods_path
    else
      render 'edit'
    end
  end

  private
    def period_params
      params.require(:period).permit(:start_time, :end_time, :participant, staff_ids: [])
    end
end