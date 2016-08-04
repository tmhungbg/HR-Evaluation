class AddStaffRefToEvaluationResult < ActiveRecord::Migration
  def change
    add_reference :evaluation_results, :resources_staff, foreign_key: true
    add_reference :evaluation_results, :target_staff, foreign_key: true
    add_column :evaluation_results, :reason, :string
  end
end
