class AddIsSupervisorToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :is_supervisor, :boolean, null: false, default: false
    add_reference :staffs, :supervisor, index: true
  end
end
