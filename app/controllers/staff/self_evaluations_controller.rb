class Staff::SelfEvaluationsController < StaffController
  def edit
    @evaluation = current_staff.current_self_evaluation
    @evaluation.initialize_evaluation_answers
  end

  def update
    if ! current_period.phase_3?
      flash[:danger] = 'Can not update evaluation in this phase'
      redirect_to staff_root_path
      return
    end

    @evaluation = current_staff.current_self_evaluation

    @evaluation.attributes = evaluation_params
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
      redirect_to staff_root_path
    else
      flash[:success] = 'Can not update, please check errors below'
      render :edit
    end
  end

  private

  def evaluation_params
    params.require(:self_evaluation)
          .permit(rel_evaluation_answers_attributes: [:id, :point, :comment,:updated_at])
  end
end