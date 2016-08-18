class SelfEvaluation < Evaluation 
  belongs_to :period
  belongs_to :staff
  
  after_save :calculate_score, if: -> { self.evaluated? }

  validates :staff, presence: true
  validates :period, presence: true

  def self.by_staff_and_period(staff, period)
    evaluation = self.find_or_create_by(staff: staff, period: period)
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

  def calculate_score
    return unless self.evaluated? && self.rel_evaluation_answers.present?
    score = self.rel_evaluation_answers.map{|a| a[:point].to_i }.sum.to_f / self.rel_evaluation_answers.length
    self.update_column(:score, score.round(1))
    EvaluationResult.find_by(staff: staff, period: period).update_score!
  end
end