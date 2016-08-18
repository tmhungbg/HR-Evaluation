class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :question_group
  
  validates :question, presence: true
  validates :question_group, presence: true
  
  before_create :add_order

  after_create :generate_answer

  def add_order
    self.display_order = Question.count + 1
  end

  def generate_answer
    self.answers.create!(
      [
        {answer:"Great",            order: 5, point: 5},
        {answer:"Very Good",        order: 4, point: 4},
        {answer:"Acceptable",       order: 3, point: 3},
        {answer:"Need Improvement", order: 2, point: 2},
        {answer:"Not Satisfied",    order: 1, point: 1}
      ]
    )
  end

  def move_order_up
    return if self.display_order.to_i <= Question.active.pluck(:display_order).min
    previous_question = Question.active.where("display_order < ?", self.display_order).order(display_order: :desc).first
    return if previous_question.blank?
    Question.transaction do
      temp = self.display_order
      self.display_order = previous_question.display_order
      previous_question.display_order = temp
      self.save!
      previous_question.save!
    end
  end

  def move_order_down
    return if self.display_order.to_i >= Question.active.pluck(:display_order).max
    previous_question = Question.active.where("display_order > ?", self.display_order).order(display_order: :desc).last
    return if previous_question.blank?
    Question.transaction do
      temp = self.display_order
      self.display_order = previous_question.display_order
      previous_question.display_order = temp
      self.save!
      previous_question.save!
    end
  end

  def generate_guideline
    result = "Guideline for question #{display_order}\n"
    answers.sort_by(&:display_order).each.with_index(1) do |answer, index|
      result << "#{index}. #{answer.answer}\n"
    end
    result
  end

  scope :active, -> { where active: true}
end