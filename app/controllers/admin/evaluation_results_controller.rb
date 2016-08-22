class Admin::EvaluationResultsController < AdminController
  def index
    period = Period.find(params[:period_id])
    @evaluation_results = EvaluationResult.joins(:staff).preload(:staff).
                                          where(period: period).order('staffs.name ASC')

    respond_to do |format|
      format.html
      format.csv do
        send_data EvaluationResult.to_csv(@evaluation_results),
                  filename: "evaluation_results-#{period.start_time}-#{period.end_time}.csv"
      end
    end
  end

  def show
    @evaluation_result = EvaluationResult.find(params[:id])
    period = @evaluation_result.period
    staff  = @evaluation_result.staff

    @self_evaluation    = SelfEvaluation.find_by(staff: staff, period: period)
    @peer_evaluations   = PeerSelection.find_by(staff: staff, period: period).peer_evaluations
    @manager_evaluation = ManagerEvaluation.find_by(staff: staff, period: period)

    @self_answers      = @self_evaluation.rel_evaluation_answers
    @peer_answers      = @peer_evaluations.map(&:rel_evaluation_answers).flatten
    @manager_answers   = @manager_evaluation.rel_evaluation_answers

    @questions = Question.preload(:answers).where(id: @self_answers.pluck(:question_id))

    if @self_evaluation.blank? || @peer_evaluations.blank? || @manager_evaluation.blank?
      redirect_to :back
      flash[:danger] = 'This evaluation does not have enough information'
      return
    end
  end
end