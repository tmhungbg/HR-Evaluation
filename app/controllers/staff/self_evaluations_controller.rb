class Staff::SelfEvaluationsController < StaffController
  def index
    @self_evaluation = SelfEvaluation.find_or_create_by(staff: current_staff, period: current_period)
  end

  def update
    @self_evaluation = SelfEvaluation.find_by(staff: current_staff, period: current_period)
    @self_evaluation.attributes = self_evaluation_params
    # Assign status
    if params[:context] == 'Save'
      @self_evaluation.status = :evaluated
      context = :evaluated
    else
      @self_evaluation.status = :temporary_save
      context = :temporary_save
    end
    if @self_evaluation.save(context: context)
      redirect_to staff_root_path
    else
      render :index
    end
  end
 
  private
  
  def self_evaluation_params
    params.require(:self_evaluation)
          .permit(rel_evaluation_answers_attributes: [:id, :point, :comment,:updated_at])
  end
end