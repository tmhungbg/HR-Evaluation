class Evaluation < ActiveRecord::Base
  enum status: [:not_evaluated, :temporary_save, :evaluated]

  belongs_to :staff
  belongs_to :period
  has_many :rel_evaluation_answers, foreign_key: :evaluation_id, dependent: :destroy
  accepts_nested_attributes_for :rel_evaluation_answers

  before_create :set_default_status

  def self.by_staff_and_period(staff, period)
    evaluation = self.find_or_create_by(staff: staff, period: period)
    evaluation.initialize_evaluation_answers if evaluation.rel_evaluation_answers.blank?
    evaluation
  end


  def initialize_evaluation_answers
    evaluation_answers = []
    Question.active.each do |question|
      evaluation_answers << {question: question, evaluation: self}
    end
    RelEvaluationAnswer.create!(evaluation_answers)
  end


  private 
  
  def set_default_status
    self.status = :not_evaluated
  end 
end