class Evaluation < ActiveRecord::Base
  enum status: [:not_evaluated, :temporary_save, :evaluated]

  belongs_to :period
  belongs_to :staff
  belongs_to :peer_selection
  belongs_to :reviewer, class_name: :Staff

  has_many :rel_evaluation_answers, dependent: :destroy
  accepts_nested_attributes_for :rel_evaluation_answers

  before_create :set_default_status
  after_create  :initialize_evaluation_answers
  after_save    :calculate_score, if: -> { self.evaluated? }

  protected

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

  private
  
  def set_default_status
    self.status = :not_evaluated
  end 
end