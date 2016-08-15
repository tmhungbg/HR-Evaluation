class SelfEvaluation < Evaluation 
  belongs_to :period
  belongs_to :staff

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
end