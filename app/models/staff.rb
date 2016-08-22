class Staff < ActiveRecord::Base
  devise :database_authenticatable, :lockable, :timeoutable, :session_limitable
  enum job: [:admin, :designer, :developer, :manager, :sales_marketing, :tester]

  belongs_to :supervisor, class_name: 'Staff', foreign_key: :supervisor_id
  has_many :evaluation_results
  has_many :periods, through: :evaluation_results
  has_many :peer_selections

  has_many :evaluations, dependent: :destroy
  has_many :peer_evaluations, through: :peer_selections
  has_many :self_evaluations
  has_many :manager_evaluations
  has_many :supervisor_evaluations

  has_one  :current_peer_selection, -> { where(period: Period.get_current_period) }, class_name: 'PeerSelection'
  has_many :current_evaluations, -> { where(period: Period.get_current_period) },
           class_name: 'Evaluation'
  has_one  :current_self_evaluation, -> { where(period: Period.get_current_period, type: 'SelfEvaluation') },
           class_name: 'Evaluation'
  has_many :current_peer_evaluations, -> { where(period: Period.get_current_period, type: 'PeerEvaluation') },
           class_name: 'Evaluation'
  has_one  :current_manager_evaluation, -> { where(period: Period.get_current_period, type: 'ManagerEvaluation') },
           class_name: 'Evaluation'
  has_one  :current_supervisor_evaluation, -> { where(period: Period.get_current_period, type: 'SupervisorEvaluation') },
           class_name: 'Evaluation'


  VALID_EMAIL_REGEX = /\A\w+@((mmj.vn)|(mmj.ne.jp))\z/i

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX },
                    length: {maximum: 30}
  validates :name, presence: true, length: {maximum: 30}
  validates :job, presence: true
  validates :display_password, length: {maximum: 10}
  validates :supervisor, presence: true

  after_create :generate_password!


  def generate_password!
    generated_password = Devise.friendly_token.first(8)
    self.password = generated_password
    self.display_password = generated_password
    self.unlock_token = nil
    self.locked_at = nil
    self.save!
    EvaluationMailer.send_account_infor(self).deliver_now
  end

  def Staff.generate_password_all! #self.generated_password_all!
    Staff.where(active: true).each do |staff|
      staff.generate_password!
    end
  end

  scope :search_name, -> (name) {
    where("name LIKE ?", "%#{name}%")
  }

  scope :active, -> { where active: true }
  scope :supervisor, -> { where is_supervisor: true }

  def self.for_period(period)
    staff_ids = self.active.pluck(:id) + period.staff_ids
    where(id: staff_ids)
  end

  def self.for_peer_selection(current_staff)
    current_period.staffs - [current_staff] - [current_staff.supervisor]
  end

  def current_period
    Period.get_current_period
  end

  def has_current_period?
    current_period.present?
  end

  def current_period_in_valid_phase?
    current_period.phase.present? && (!current_period.phase_6?) && (!current_period.phase_1?)
  end

  def valid_staff?
    self.active  && self.current_period_in_valid_phase?
  end

  def get_current_reviwer_name
    return if current_peer_selection.blank?
    current_peer_selection.reviewers.map(&:name).join(', ')
  end

  def get_current_self_evaluation_status
    if current_self_evaluation.try(:evaluated?)
      return 'Done'
    else
      return '--'
    end
  end

  def get_current_peer_evaluation_status
    reviewd_evaluations = PeerEvaluation.where(reviewer: self, period: Period.get_current_period)
    evaluated_evaluations = reviewd_evaluations.select(&:evaluated?)
    if evaluated_evaluations.length == reviewd_evaluations.length
      'Done'
    else
      "#{evaluated_evaluations.length} / #{reviewd_evaluations.length}"
    end
  end

  def get_current_supervisor_evaluation_status
    if current_supervisor_evaluation.try(:evaluated?)
      return 'Done'
    else
      return '--'
    end
  end

  def get_current_manager_evaluation_status
    if current_manager_evaluation.try(:evaluated?)
      return 'Done'
    else
      return '--'
    end
  end

  def display_is_senior
    is_senior ? 'Yes' : 'No'
  end

  def display_is_supervisor
    is_supervisor ? 'Yes' : 'No'
  end

  def get_options_for_supervisor
    Staff.active.supervisor.where.not(id: self.id).order(:name)
  end
end

