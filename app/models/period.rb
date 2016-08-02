class Period < ActiveRecord::Base
  has_many :evaluation_results
  has_many :staffs, through: :evaluation_results

   enum phase: [:phase_1, :phase_2, :phase_3, :phase_4, :phase_5, :phase_6]

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_less_than_end_time
  validate :not_overlap

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
end
