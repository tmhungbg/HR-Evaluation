class Evaluation < ActiveRecord::Base
  enum status: [:not_evaluated, :temporary_save, :evaluated]

  belongs_to :period
  belongs_to :staff
  belongs_to :peer_selection
  belongs_to :reviewer, class_name: :Staff

  has_many :rel_evaluation_answers, dependent: :destroy
  accepts_nested_attributes_for :rel_evaluation_answers

  before_create :set_default_status
  after_save    :calculate_score, if: -> { self.evaluated? }

  validates :period, presence: true, unless: -> { type == 'PeerEvaluation' }
  validates :staff, presence: true, unless: -> { type == 'PeerEvaluation' }
  validates :reviewer, presence: true, if: -> { type == 'PeerEvaluation' || type == 'SupervisorEvaluation'}

  def initialize_evaluation_answers
    return if rel_evaluation_answers.present?
    evaluation_answers = []
    Question.active.each do |question|
      evaluation_answers << {question: question, evaluation: self, point: :not_selected}
    end
    RelEvaluationAnswer.create!(evaluation_answers)
    self.reload
  end

  def calculate_score
    return unless self.evaluated? && self.rel_evaluation_answers.present?
    calculated_answers = self.rel_evaluation_answers.select{ |a| a[:point] > 0 }
    score = calculated_answers.map{ |a| a[:point] }.sum.to_f / calculated_answers.length
    self.update_column(:score, score.round(1))
    EvaluationResult.find_by(staff: staff, period: period).update_score!
  end

  private

  def set_default_status
    self.status = :not_evaluated
  end
end