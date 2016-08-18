class Evaluation < ActiveRecord::Base
  enum status: [:not_evaluated, :temporary_save, :evaluated]

  has_many :rel_evaluation_answers, foreign_key: :evaluation_id, dependent: :destroy
  accepts_nested_attributes_for :rel_evaluation_answers

  before_create :set_default_status

  private
  
  def set_default_status
    self.status = :not_evaluated
  end 
end