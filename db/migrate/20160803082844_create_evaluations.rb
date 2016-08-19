class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.references :peer_selection, index: true, foreign_key: true
      t.references :reviewer, index: true, references: :staffs
      t.references :staff, index: true, foreign_key: true
      t.references :period, index: true, foreign_key: true
      t.string :type
      t.decimal :score
      t.timestamps null: false
    end

    add_foreign_key :evaluations, :staffs, column: :reviewer_id
  end
end
