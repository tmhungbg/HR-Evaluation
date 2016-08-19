class PeerSelection < ActiveRecord::Base
  belongs_to :period
  belongs_to :staff
  has_many :peer_evaluations, dependent: :destroy
  has_many :reviewers, through: :peer_evaluations

  validates :staff, presence: true
  validates :period, presence: true

  validate :reason_require
  validate :reviewers_number

  def reason_require
    return if self.new_record?
    errors.add(:reason, "can't be blank") if reviewers.count < 3 && reason.to_s.strip.blank?
  end

  def reviewers_number
    return if self.new_record?
    errors.add(:reviewer_ids, "you can not choose more than 3 reviewers") if reviewers.count > 3
  end
end
