class PeerEvaluation < Evaluation 
  belongs_to :peer_selection
  belongs_to :reviewer, foreign_key: :staff_id, class_name: :Staff
end