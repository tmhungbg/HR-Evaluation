class Staff::SelfEvaluationsController < StaffController
  def index
    @self_evaluation = SelfEvaluation.find_or_create_by(staff: current_staff, period: current_period)
  end

  def update
    @self_evaluation = SelfEvaluation.find_by(staff: current_staff, period: current_period)
    if @self_evaluation.update(self_evaluation_params)
      redirect_to staff_root_path
    else
      render :index
    end
  end

  private
  
  def self_evaluation_params
    params.require(:self_evaluation).permit(:score)
  end
end