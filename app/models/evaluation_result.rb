class EvaluationResult < ActiveRecord::Base
  belongs_to :staff
  belongs_to :period

  def update_scores(period)
    
  end
end
