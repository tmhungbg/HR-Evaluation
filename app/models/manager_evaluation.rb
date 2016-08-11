class ManagerEvaluation < Evaluation 
  belongs_to :staff
  belongs_to :period
  has_many :rel_evaluation_answer
end