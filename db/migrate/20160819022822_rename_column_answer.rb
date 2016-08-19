class RenameColumnAnswer < ActiveRecord::Migration
  def change
    rename_column :answers, :answer, :name
  end
end
