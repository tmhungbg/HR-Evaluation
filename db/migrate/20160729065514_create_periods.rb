class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :participant
      t.timestamps null: false
    end
  end
end
