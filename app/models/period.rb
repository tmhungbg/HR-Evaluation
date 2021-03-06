class Period < ActiveRecord::Base
  has_many :evaluation_results
  has_many :evaluation
  has_many :staffs, through: :evaluation_results

  enum phase: [:phase_1, :phase_2, :phase_3, :phase_4, :phase_5, :phase_6]

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_less_than_end_time
  validate :not_overlap

  after_save :initialize_evaluations

  def start_time_less_than_end_time
    return if start_time.blank? || end_time.blank?
    errors.add(:end_time, "must be larger than start_time") if start_time > end_time
  end

  def not_overlap
    errors.add(:end_time, 'is overlaps') if  overlap?
  end


  def overlap?
    return if start_time.blank? || end_time.blank? || start_time > end_time
    Period.where.not(id: id).each do |period|
      return true unless self.start_time > period.end_time || self.end_time < period.start_time
    end
    return false
  end

  def outdate?
    return if self.end_time.blank?
    self.end_time < Date.current
  end

  def current_period?
    return if self.start_time.blank? || self.end_time.blank?
    self.start_time <= Date.current && self.end_time >= Date.current
  end

  def can_edit?
    end_time && Date.current <= end_time
  end

  def staff_names
    staffs.map(&:name).join(', ')
  end

  def show_time
    "#{start_time} - #{end_time}"
  end

  def self.get_current_period
    Period.all.find{ |p| p.current_period? }
  end

  def self.send_account_infor
    staffs = get_current_period.staffs
    managers = Manager.where(active: true)

    staffs.each do |staff|
      EvaluationMailer.send_account_infor(staff).deliver_now
    end

    managers.each do |manager|
      EvaluationMailer.send_account_infor(manager).deliver_now
    end
  end

  private

  def initialize_evaluations
    PeerSelection.where(period: self).where.not(staff_id: self.staff_ids).destroy_all
    Evaluation.where(period: self).where.not(staff_id: self.staff_ids).destroy_all
  end
end
