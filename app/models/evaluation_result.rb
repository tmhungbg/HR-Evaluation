class EvaluationResult < ActiveRecord::Base
  belongs_to :staff
  belongs_to :period

  after_create :initialize_evaluations

  def self.update_scores(period =  Period.get_current_period)
    raise StandardError, 'period is not finished yet' unless period.phase_5? || period.phase_6?
    results = where(period: period)
    results.each { |result|  result.update_score! }
  end

  def update_score!
    self_evaluation    = SelfEvaluation.evaluated.find_by(staff: staff, period: period)
    peer_selection     = PeerSelection.find_by(staff: staff, period: period)
    peer_evaluations   = peer_selection.peer_evaluations.evaluated
    manager_evaluation = ManagerEvaluation.evaluated.find_by(staff: staff, period: period)
    return if self_evaluation.blank? || peer_evaluations.blank? || manager_evaluation.blank?
    self_score = self_evaluation.score
    peer_score = peer_evaluations.map(&:score).sum.to_f / peer_evaluations.length
    manager_score = manager_evaluation.score
    final_scoe = (EVALUATION_WEIGHT[:self] * self_score +
                  EVALUATION_WEIGHT[:peer] * peer_score +
                  EVALUATION_WEIGHT[:manager] * manager_score).round(1)
    self.update!(score: final_scoe.round(1))
  end

  def initialize_evaluations
    SelfEvaluation.create!(staff: staff, period: period)
    ManagerEvaluation.create!(staff: staff, period: period)
    PeerSelection.create!(staff: staff, period: period)
  end
end
