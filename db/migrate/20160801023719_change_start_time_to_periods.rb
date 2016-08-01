class ChangeStartTimeToPeriods < ActiveRecord::Migration
  def change
    change_column :periods, :start_time, :date
    change_column :periods, :end_time, :date
  end
end
