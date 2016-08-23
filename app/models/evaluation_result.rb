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
    self_evaluation       = SelfEvaluation.evaluated.find_by(staff: staff, period: period)
    supervisor_evaluation = SupervisorEvaluation.evaluated.find_by(staff: staff, period: period)
    peer_selection        = PeerSelection.find_by(staff: staff, period: period)
    peer_evaluations      = peer_selection.try(:peer_evaluations).try(:evaluated)
    manager_evaluation    = ManagerEvaluation.evaluated.find_by(staff: staff, period: period)
    return if self_evaluation.blank? || manager_evaluation.blank?
    final_score = 0
    self_score       = self_evaluation.score
    manager_score    = manager_evaluation.score
    supervisor_score = supervisor_evaluation.score if supervisor_evaluation.present?
    peer_score       = peer_evaluations.map(&:score).sum.to_f / peer_evaluations.length if peer_evaluations.present?

    evaluation_weight = EvaluationWeight.first

    if peer_evaluations.present? && supervisor_evaluation.present?
      final_score =   evaluation_weight.normal_self       * self_score       +
                      evaluation_weight.normal_supervisor * supervisor_score +
                      evaluation_weight.normal_peer       * peer_score       +
                      evaluation_weight.normal_manager    * manager_score

    elsif supervisor_evaluation.present?
      final_score =   evaluation_weight.without_peer_self       * self_score       +
                      evaluation_weight.without_peer_supervisor * supervisor_score +
                      evaluation_weight.without_peer_manager    * manager_score
    elsif peer_evaluations.present?
      final_score =   evaluation_weight.without_super_self    * self_score    +
                      evaluation_weight.without_super_peer    * peer_score    +
                      evaluation_weight.without_super_manager * manager_score
    else
      final_score =   evaluation_weight.without_peer_and_super_self    * self_score +
                      evaluation_weight.without_peer_and_super_manager * manager_score
    end

    self.update!(score: final_score.round(1))
  end

  def initialize_evaluations
    SelfEvaluation.create!(staff: staff, period: period)
    SupervisorEvaluation.create!(staff: staff, period: period, reviewer: staff.supervisor)
    ManagerEvaluation.create!(staff: staff, period: period)
    PeerSelection.create!(staff: staff, period: period)
  end

  def self.to_csv(results)
    require 'csv'
    headers = %w(Name Job Score)
    CSV.generate(headers: true) do |csv|
      csv << headers

      results.each do |result|
        csv << [result.staff.name, result.staff.job, result.score]
      end
    end
  end
end
