class UpdateToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :name, :string
    add_column :staffs, :job, :integer
  end
end
