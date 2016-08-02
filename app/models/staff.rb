class Staff < ActiveRecord::Base
  devise :database_authenticatable, :lockable, :timeoutable, :session_limitable

  VALID_EMAIL_REGEX = /\A\w+@((mmj.vn)|(mmj.ne.jp))\z/i

  has_many :evaluation_results


  enum job: [:admin, :designer, :developer, :manager, :sales_maketing, :tester]

  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }, 
                    length: {maximum: 30}
  validates :name, presence: true, length: {maximum: 30}
  validates :job, presence: true
  validates :display_password, length: {maximum: 10}

  after_create :generate_password!


  def generate_password!
    generated_password = Devise.friendly_token.first(8)
    self.password = generated_password
    self.display_password = generated_password
    self.save!
  end

  def Staff.generate_password_all! #self.generated_password_all!
    Staff.where(active: true).each do |staff|
      staff.generate_password!
    end
  end

  scope :search_name, -> (name) {
    where("name LIKE ?", "%#{name}")
  }

  scope :active, -> { where active: true }

  def self.for_period(period)
    staff_ids = self.active.pluck(:id) + period.staff_ids
    where(id: staff_ids)
  end
end

