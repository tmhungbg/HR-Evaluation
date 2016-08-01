class Admin::PeriodsController < AdminController
  def new
    @period = Period.new
  end

  def index
    @periods = Period.all
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
    # @staff_ids = @period.evaluation_results.pluck(:staff_id)
  end

  def update
    @period = Period.find(params[:id])
    # @staff_ids = @period.evaluation_results.pluck(:staff_id)
    if @period.update(period_params)
      # params[:staff_ids].each do |staff_id|
      #   if @staff_ids.exclude?(staff_id)
      #     EvaluationResult.create(staff_id: staff_id, period: @period)
      #   end 
      #   @staff_ids.delete(staff_id)
      # end
      # EvaluationResult.where(staff_id: @staff_ids).destroy_all

      redirect_to admin_periods_path
    else
      render 'edit'
    end
  end

  def destroy
    @period = Period.find(params[:id])
    @period.update(active: false)
    redirect_to admin_periods_path
  end
  private
    def period_params
      params.require(:period).permit(:start_time, :end_time, :participant, staff_ids: [])
    end
end