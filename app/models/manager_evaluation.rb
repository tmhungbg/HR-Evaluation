class ManagerEvaluation < Evaluation
  belongs_to :staff
  belongs_to :period

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
end
