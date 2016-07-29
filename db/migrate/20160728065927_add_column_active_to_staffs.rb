class AddColumnActiveToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :active, :boolean, default: true
  end
end
