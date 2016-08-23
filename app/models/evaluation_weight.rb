class EvaluationWeight < ActiveRecord::Base
  validates :normal_self, presence: true
  validates :normal_peer, presence: true
  validates :normal_manager, presence: true
  validates :normal_supervisor, presence: true
  validates :without_peer_self, presence: true
  validates :without_peer_manager, presence: true
  validates :without_peer_supervisor, presence: true
  validates :without_super_self, presence: true
  validates :without_super_manager, presence: true
  validates :without_super_peer, presence: true
  validates :without_peer_and_super_self, presence: true
  validates :without_peer_and_super_manager, presence: true
end
