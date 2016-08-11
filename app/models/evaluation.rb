class Evaluation < ActiveRecord::Base
  enum status: [:not_evaluated, :temporary_save, :evaluated]

  before_create :set_default_status

  def set_default_status
    self.status = :not_evaluated
  end
end