class CreateEvaluationWeights < ActiveRecord::Migration
  def change
    create_table :evaluation_weights do |t|
      t.float :normal_self, null: false, default: 0.1
      t.float :normal_peer, null: false, default: 0.15
      t.float :normal_manager, null: false, default: 0.45
      t.float :normal_supervisor, null: false, default: 0.30

      t.float :without_peer_self, null: false, default: 0.10
      t.float :without_peer_manager, null: false, default: 0.60
      t.float :without_peer_supervisor, null: false, default: 0.30

      t.float :without_super_self, null: false, default: 0.1
      t.float :without_super_manager, null: false, default: 0.75
      t.float :without_super_peer, null: false, default: 0.15

      t.float :without_peer_and_super_self, null: false, default: 0.1
      t.float :without_peer_and_super_manager, null: false, default: 0.9

      t.timestamps null: false
    end
  end
end