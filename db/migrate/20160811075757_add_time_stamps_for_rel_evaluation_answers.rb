class AddTimeStampsForRelEvaluationAnswers < ActiveRecord::Migration
  def change
    change_table :rel_evaluation_answers do |t|
      t.timestamps
    end
  end
end
