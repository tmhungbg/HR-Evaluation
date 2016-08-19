class ManagerEvaluation < Evaluation
  validates :period, presence: true
  validates :staff, presence: true
end
