class Evaluation < ActiveRecord::Base
  enum status: [:not_evaluated, :temporary_save, :evaluated]

  has_many :rel_evaluation_answers, foreign_key: :evaluation_id, dependent: :destroy
  accepts_nested_attributes_for :rel_evaluation_answers

  before_create :set_default_status

  def self.update_scores(period)
    self_evaluations = SelfEvaluation.where(period: period)
    manager_evaluations = ManagerEvaluation.where(period: period)
    peer_evaluations = PeerEvaluation.joins(:peer_selection).merge(PeerSelection.where(period: period))
    self_evaluations.each{ |e| e.calculate_score! }
    manager_evaluations.each{ |e| e.calculate_score! }
    peer_evaluations.each{ |e| e.calculate_score! }
  end

  def calculate_score!
    return if self.rel_evaluation_answers.blank?
    score = self.rel_evaluation_answers.map{|a| a[:point].to_i }.sum.to_f / self.rel_evaluation_answers.length
    self.update!(score: score)
  end

  private
  
  def set_default_status
    self.status = :not_evaluated
  end 
end