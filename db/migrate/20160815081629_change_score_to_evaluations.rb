class ChangeScoreToEvaluations < ActiveRecord::Migration
  def change
    change_column :evaluations, :score, :float
  end
end
