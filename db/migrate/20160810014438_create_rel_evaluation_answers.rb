class CreateRelEvaluationAnswers < ActiveRecord::Migration
  def change
    create_table :rel_evaluation_answers do |t|
      t.references :evaluation, index: true
      t.string :comment
    end
    add_foreign_key :rel_evaluation_answers, :evaluations, dependent: :delete
  end
end
