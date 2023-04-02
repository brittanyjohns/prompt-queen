class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.belongs_to :prompt, null: false, foreign_key: true
      t.belongs_to :template_question, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
