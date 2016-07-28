class RemoveColumnPasswordToStaffs < ActiveRecord::Migration
  def change
    remove_column :staffs, :password, :string
  end
end
