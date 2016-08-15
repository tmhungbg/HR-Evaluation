class Staff::EvaluationResultsController < StaffController
  def index
    @self_answers = SelfEvaluation.by_staff_and_period(current_staff, current_period).rel_evaluation_answers
    @peer_answers = PeerSelection.find_by(staff: current_staff, period: current_period).
                                  peer_evaluations.map(&:rel_evaluation_answers).flatten
    @manager_answers = ManagerEvaluation.find_by(staff: current_staff, period: current_period).rel_evaluation_answers
  end
end