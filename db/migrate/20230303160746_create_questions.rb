class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.belongs_to :prompt_, null: false, foreign_key: true
      t.string :name
      t.integer :question_type

      t.timestamps
    end
  end
end
