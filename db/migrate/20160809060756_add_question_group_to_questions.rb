class AddQuestionGroupToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :question_group, index: true, foreign_key: true
  end
end
