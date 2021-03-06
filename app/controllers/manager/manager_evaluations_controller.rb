class Manager::ManagerEvaluationsController < ManagerController
  def edit
    if ! current_period.phase_4?
      flash[:danger] = 'Can not update evaluation in this phase'
      redirect_to manager_root_path
      return
    end
    @evaluation = ManagerEvaluation.find(params[:id])
    @evaluation.initialize_evaluation_answers
  end

  def update
    if ! current_period.phase_4?
      flash[:danger] = 'Can not update evaluation in this phase'
      redirect_to manager_root_path
      return
    end
    @evaluation = ManagerEvaluation.find(params[:id])
    @evaluation.attributes = manager_evaluation_params
    # Assign status
    if params[:context] == 'Save'
      @evaluation.status = :evaluated
      context = :evaluated
    else
      @evaluation.status = :temporary_save
      context = :temporary_save
    end
    if @evaluation.save(context: context)
      flash[:success] = 'Updated successfully'
      redirect_to manager_root_path
    else
      flash[:success] = 'Can not update, please check errors below'
      render :edit
    end
  end

  private

  def manager_evaluation_params
    params.require(:manager_evaluation)
          .permit(rel_evaluation_answers_attributes: [:id, :point, :comment,:updated_at])
  end
end