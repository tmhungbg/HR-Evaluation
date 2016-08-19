class AddColumnDateStartWorkToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :date_start_work, :date
  end
end
