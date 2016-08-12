class AddPointToRelEvaluationAnswers < ActiveRecord::Migration
  def change
    add_column :rel_evaluation_answers, :point, :integer
  end
end
