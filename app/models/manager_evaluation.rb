class ManagerEvaluation < Evaluation
  belongs_to :staff
  belongs_to :period

  after_save :calculate_score, if: -> { self.evaluated? }

  validates :staff, presence: true
  validates :period, presence: true

  def self.by_period(period)
    intialize_manager_evaluations(period)
    where(period: period)
  end

  def self.intialize_manager_evaluations(period)
    staffs = period.staffs
    manager_evaluations = ManagerEvaluation.where(period: period)
    staffs.each do |staff|
      if manager_evaluations.find{ |e|  e.staff_id == staff.id }.blank?
        evaluation = ManagerEvaluation.create!(staff: staff, period: period)
        evaluation.initialize_evaluation_answers 
      end
    end
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
