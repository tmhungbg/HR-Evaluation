class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers

  belongs_to :question_group
  
  validates :name, presence: true
  validates :question_group, presence: true
  
  before_create :add_order

  after_create :generate_answer

  def add_order
    self.display_order = Question.count + 1
  end

  def generate_answer
    self.answers.create!(
      [
        {name:"Great",            display_order: 5, point: 5},
        {name:"Very Good",        display_order: 4, point: 4},
        {name:"Acceptable",       display_order: 3, point: 3},
        {name:"Need Improvement", display_order: 2, point: 2},
        {name:"Not Satisfied",    display_order: 1, point: 1}
      ]
    )
  end

  def build_answer
    self.answers.build(
      [
        {name:"Great",            display_order: 5, point: 5},
        {name:"Very Good",        display_order: 4, point: 4},
        {name:"Acceptable",       display_order: 3, point: 3},
        {name:"Need Improvement", display_order: 2, point: 2},
        {name:"Not Satisfied",    display_order: 1, point: 1}
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
      result << "#{index}. #{answer.name}\n"
    end
    result
  end

  scope :active, -> { where active: true}
end