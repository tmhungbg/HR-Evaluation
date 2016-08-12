class ChangeOrderToDisplayOrder < ActiveRecord::Migration
  def change
    rename_column :questions, :order, :display_order
  end
end
