class AddShorDescriptionToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :short_description, :string
  end
end
