class PeerEvaluation < Evaluation 
  belongs_to :peer_selection
  belongs_to :reviewer, foreign_key: :staff_id, class_name: :Staff

  def self.get_by_staff_and_period(staff, period)
    peer_selections = PeerSelection.where(period: period)
    where(reviewer: staff, peer_selection: peer_selections)
  end

  def self.find_and_initialize(staff, period, peer_evaluation_id)
    evaluation = self.get_by_staff_and_period(staff, period).find(peer_evaluation_id)
    evaluation.initialize_evaluation_answers if evaluation.rel_evaluation_answers.blank?
    evaluation.reload
  end

  def initialize_evaluation_answers
    evaluation_answers = []
    Question.active.each do |question|
      evaluation_answers << {question: question, evaluation: self}
    end
    RelEvaluationAnswer.create!(evaluation_answers)
  end
end