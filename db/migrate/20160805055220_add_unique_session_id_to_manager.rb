class AddUniqueSessionIdToManager < ActiveRecord::Migration
  def change
    add_column :managers, :unique_session_id, :string, limit: 20
  end
end
