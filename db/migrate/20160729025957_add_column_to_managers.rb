class AddColumnToManagers < ActiveRecord::Migration
  def change
    add_column :managers, :display_password, :string
    add_column :managers, :name, :string
    add_column :managers, :job, :integer
    add_column :managers, :active, :boolean, default: true
  end
end
