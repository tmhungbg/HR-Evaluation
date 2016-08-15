class Manager::ManagerEvaluationsController < ManagerController
  def edit
    @manager_evaluation = ManagerEvaluation.by_period(current_period).find(params[:id])
  end

  def update
    @manager_evaluation = ManagerEvaluation.by_period(current_period).find(params[:id])
    @manager_evaluation.attributes = manager_evaluation_params
    # Assign status
    if params[:context] == 'Save'
      @manager_evaluation.status = :evaluated
      context = :evaluated
    else
      @manager_evaluation.status = :temporary_save
      context = :temporary_save
    end
    if @manager_evaluation.save(context: context)
      redirect_to manager_root_path
    else
      render :edit
    end
  end
 
  private
  
  def manager_evaluation_params
    params.require(:manager_evaluation)
          .permit(rel_evaluation_answers_attributes: [:id, :point, :comment,:updated_at])
  end
end