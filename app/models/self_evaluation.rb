class SelfEvaluation < Evaluation 
  belongs_to :staff
  belongs_to :period
  has_many :rel_evaluation_answers, foreign_key: :evaluation_id, dependent: :destroy
  accepts_nested_attributes_for :rel_evaluation_answers

  after_create :initialize_evaluation_answers

  private

  def initialize_evaluation_answers
    evaluation_answers = []
    Question.active.each do |question|
      evaluation_answers << {question: question, evaluation: self}
    end
    RelEvaluationAnswer.create!(evaluation_answers)
  end
end