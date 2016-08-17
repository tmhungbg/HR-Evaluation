class RelEvaluationAnswer < ActiveRecord::Base
  belongs_to :question
  belongs_to :evaluation 

  enum point: {
    greate: 5,
    very_good: 4,
    acceptable: 3,
    need_improvement: 2,
    not_satisfied: 1
  }

  validates :evaluation, presence: true
  validates :question, presence: true, uniqueness: { scope: :evaluation_id }
  validates :point, inclusion: { in: points.keys }, allow_blank: true
  validates :comment, length: { maximum: 255 }

  validates :point, presence: true, on: :evaluated
  # validates :comment, presence: true, 
  #           if: -> { p point; point.present? && point != 'acceptable' }, 
  #           on: :evaluated
end