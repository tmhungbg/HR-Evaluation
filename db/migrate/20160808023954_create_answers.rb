class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :answer
      t.integer :order
      t.integer :point
      t.timestamps null: false
    end
  end
end
