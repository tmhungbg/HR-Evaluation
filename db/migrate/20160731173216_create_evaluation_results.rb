class CreateEvaluationResults < ActiveRecord::Migration
  def change
    create_table :evaluation_results do |t|
      t.references :staff, index: true, foreign_key: true
      t.references :period, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
