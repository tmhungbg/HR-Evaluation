class Manager < ActiveRecord::Base
  devise :database_authenticatable,
         :lockable, :timeoutable,:session_limitable

  VALID_EMAIL_REGEX = /\A\w+@((mmj.vn)|(mmj.ne.jp))\z/i

  enum job: [:admin, :disigner, :developer, :manager, :sales_marketing, :tester]

  validates :email, presence:
                     true, uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }, 
                    length: {maximum: 30}
  validates :name, presence: true, length: {maximum: 30}
  validates :job, presence: true
  validates :display_password, length: {maximum: 10}
  
  after_create :generate_password!

  scope :search_name, -> (name) {
    where("name LIKE ?", "%#{name}%" )
  }

  def generate_password!
    generated_password = Devise.friendly_token.first(8)
    self.password = generated_password
    self.display_password = generated_password
    self.unlock_token = nil
    self.locked_at = nil
    self.save!
  end

  def Manager.generate_password_all!
    Manager.where(active: true).each do |manager|
      manager.generate_password!
    end
  end

  def current_period
    Period.get_current_period
  end

  def has_current_period?
    current_period.present?
  end

  def current_period_in_valid_phase?
    current_period.phase.present? && (!current_period.phase_6?)
  end

  def valid_manager?
    self.active && self.has_current_period? && self.current_period_in_valid_phase?
  end
end
