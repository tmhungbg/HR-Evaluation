class PeerEvaluation < Evaluation 
  validates :reviewer, presence: true

  after_create :update_staff_period

  def update_staff_period
    return if peer_selection.blank?
    self.update!(staff: peer_selection.staff, period: peer_selection.period)
  end
end