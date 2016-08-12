class Staff::PeerEvaluationsController < StaffController
  def index
    @peer_evaluations = PeerEvaluation.get_by_staff_and_period(current_staff, current_period)
  end

  def edit
    @peer_evaluation = PeerEvaluation.find_and_initialize(current_staff, current_period,params[:id])
    @peer_evaluation.rel_evaluation_answers
  end

  def update
    @peer_evaluation = PeerEvaluation.find_and_initialize(current_staff, current_period,params[:id])
    @peer_evaluation.attributes = peer_evaluation_params
    # Assign status
    if params[:context] == 'Save'
      @peer_evaluation.status = :evaluated
      context = :evaluated
    else
      @peer_evaluation.status = :temporary_save
      context = :temporary_save
    end
    if @peer_evaluation.save(context: context)
      redirect_to staff_peer_evaluations_path
    else
      render :edit
    end
  end

  private

  def peer_evaluation_params
    params.require(:peer_evaluation)
          .permit(rel_evaluation_answers_attributes: [:id, :point, :comment, :updated_at])
  end
end
