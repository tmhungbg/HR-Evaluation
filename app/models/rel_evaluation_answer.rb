class RelEvaluationAnswer < ActiveRecord::Base
  belongs_to :question
  belongs_to :evaluation

  enum point: {
    greate:           5,
    very_good:        4,
    acceptable:       3,
    need_improvement: 2,
    not_satisfied:    1,
    not_selected:     0,
    can_not_evaluate: -1
  }

  validates :evaluation, presence: true
  validates :question, presence: true, uniqueness: { scope: :evaluation_id }
  validates :point, inclusion: { in: points.keys }, allow_blank: true
  validates :comment, length: { maximum: 255 }

  validates :point, presence: true, on: :evaluated
  validate  :valid_point, on: :evaluated
  validate  :valid_comment, on: :evaluated

  def valid_comment
    return if comment.strip.present?
    if (evaluation.staff.is_senior? && !very_good?) || (!evaluation.staff.is_senior? && !acceptable?)
      errors.add(:comment, "can't be blank")
    end
  end

  def valid_point
    return if point.blank?
    errors.add(:point, 'Please choose an answer') if self.not_selected?
  end

  def self.choise_for_question(question)
    result = []
    result << ["not_selected", 'Not selected']
    result << ["can_not_evaluate", 'Can not evaluate']
    question.answers.sort_by(&:point).reverse.each do |answer|
      case answer.point
      when 5
        result << ["greate", answer.name]
      when 4
        result << ["very_good", answer.name]
      when 3
        result << ["acceptable", answer.name]
      when 2
        result << ["need_improvement", answer.name]
      when 1
        result << ["not_satisfied", answer.name]
      end
    end
    result
  end
end