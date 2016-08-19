class RenameColumnQuestion < ActiveRecord::Migration
  def change
    rename_column :questions, :question, :name
  end
end
