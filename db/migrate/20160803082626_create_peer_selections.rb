class CreatePeerSelections < ActiveRecord::Migration
  def change
    create_table :peer_selections do |t|
      t.references :period, index: true, foreign_key: true
      t.references :staff, index: true, foreign_key: true
      t.string :reason

      t.timestamps null: false
    end
  end
end
