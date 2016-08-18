class ChangeOrderOfAnswers < ActiveRecord::Migration
  def change
    rename_column :answers, :order, :display_order
  end
end
