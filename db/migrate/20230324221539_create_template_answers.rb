class CreateTemplateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :template_answers do |t|
      t.belongs_to :template_question, null: false, foreign_key: true
      t.string :name
      t.string :answer_type

      t.timestamps
    end
  end
end
