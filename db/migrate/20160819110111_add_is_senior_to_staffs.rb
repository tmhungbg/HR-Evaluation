class AddIsSeniorToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :is_senior, :boolean, null: false, default: false
  end
end
