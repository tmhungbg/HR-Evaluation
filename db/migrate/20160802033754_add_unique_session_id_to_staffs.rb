class AddUniqueSessionIdToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :unique_session_id, :string, limit: 20
  end
end
