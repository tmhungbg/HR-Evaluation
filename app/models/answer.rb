class Answer < ActiveRecord::Base
  belongs_to :question

  validates :name, presence: true, length: { maximum: 255 }
  validates :point, presence: true
  validates :display_order, presence: true
end