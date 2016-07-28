class AddSessionLimitableToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :unique_session_id, :string, :limit => 20
  end
end
