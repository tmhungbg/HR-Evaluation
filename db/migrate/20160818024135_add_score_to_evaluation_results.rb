class AddScoreToEvaluationResults < ActiveRecord::Migration
  def change
    add_column :evaluation_results, :score, :float
  end
end
