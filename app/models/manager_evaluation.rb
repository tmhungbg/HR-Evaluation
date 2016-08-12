class ManagerEvaluation < Evaluation
  belongs_to :staff
  belongs_to :period

  def self.get_by_staff_and_period(staff, period)
    
  end
end
