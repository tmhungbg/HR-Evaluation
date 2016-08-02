class AddColumnPhaseToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :phase, :integer
  end
end
