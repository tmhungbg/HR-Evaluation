class Admin::PeriodsController < AdminController
  def new
    @period = Period.new
    @period.staff_ids = Staff.active.pluck(:id)
  end

  def show
    @period = Period.find(params[:id]) 
  end

  def index
    @periods = Period.preload(:staffs).all.order(end_time: :DESC)
  end

  def create
    @period = Period.new(period_params)
    if @period.save
      flash[:success] = "Created successfully"
      redirect_to admin_periods_path
    else
      render 'new'
    end
  end
 
  def edit
    @period = Period.find(params[:id])
    redirect_to admin_periods_path if @period.outdate?
  end

  def update
    @period = Period.find(params[:id])
    redirect_to admin_periods_path if @period.outdate?
    if @period.update(period_params)
      flash[:success] = "Updated successfully"
      redirect_to admin_periods_path
    else
      render 'edit'
    end
  end

  def send_account_infor
    if current_period.blank?
      flash[:danger] = 'There is not current period'
      redirect_to :admin_periods_path
      return
    end

    Period.send_account_infor
    flash[:success] = "Sent account information successfully"
    redirect_to admin_periods_path
  end

  private
    def period_params
      params.require(:period).permit(:start_time, :end_time, :phase, staff_ids: [])
    end
end