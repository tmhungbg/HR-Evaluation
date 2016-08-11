class PeerEvaluation < Evaluation 
  belongs_to :peer_selection
  belongs_to :reviewer, foreign_key: :staff_id, class_name: :Staff
  has_many :rel_evaluation_answer  

  def temporaty_saved(self_evaluation)
    
  end

  def evaluated()
  end
end