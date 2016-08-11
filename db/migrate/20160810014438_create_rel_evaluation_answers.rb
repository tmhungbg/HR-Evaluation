class CreateRelEvaluationAnswers < ActiveRecord::Migration
  def change
    create_table :rel_evaluation_answers do |t|
      t.references :evaluation, index: true, foreign_key: true
      t.string :comment
    end
  end
end
