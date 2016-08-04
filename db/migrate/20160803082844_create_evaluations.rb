class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.references :peer_selection, index: true, foreign_key: true
      t.references :staff, index: true, foreign_key: true
      t.references :period, index: true, foreign_key: true
      t.string :type
      t.decimal :score
    end
  end
end
