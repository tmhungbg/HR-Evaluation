class AddColumnDisplayPasswordToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :display_password, :string
  end
end
