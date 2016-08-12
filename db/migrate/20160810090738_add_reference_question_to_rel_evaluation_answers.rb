class AddReferenceQuestionToRelEvaluationAnswers < ActiveRecord::Migration
  def change
      add_reference :rel_evaluation_answers, :question, index: true, foreign_key: true
  end
end
