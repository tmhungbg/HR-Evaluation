class Staff::EvaluationResultsController < StaffController
  def index
    if ! current_period.phase_5?
      flash[:danger] = 'Can not see result in this phase'
      redirect_to staff_root_path
      return
    end
    @evaluation_result = EvaluationResult.find_by(staff: current_staff, period: current_period)
    period = @evaluation_result.period
    staff  = @evaluation_result.staff

    @self_evaluation       = SelfEvaluation.evaluated.find_by(staff: staff, period: period)
    @supervisor_evaluation = SupervisorEvaluation.evaluated.find_by(staff: staff, period: period)
    @peer_evaluations      = PeerSelection.find_by(staff: staff, period: period).peer_evaluations.evaluated
    @manager_evaluation    = ManagerEvaluation.evaluated.find_by(staff: staff, period: period)

    @self_answers       = @self_evaluation.rel_evaluation_answers
    @supervisor_answers = @supervisor_evaluation.rel_evaluation_answers if @supervisor_evaluation.present?
    @peer_answers       = @peer_evaluations.map(&:rel_evaluation_answers).flatten if @peer_evaluations.present?
    @manager_answers    = @manager_evaluation.rel_evaluation_answers

    @questions = Question.preload(:answers).where(id: @self_answers.pluck(:question_id))
  end
end