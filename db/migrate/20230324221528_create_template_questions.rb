class CreateTemplateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :template_questions do |t|
      t.belongs_to :prompt_template, null: false, foreign_key: true
      t.string :name
      t.integer :question_type
      t.string :display_name

      t.timestamps
    end
  end
end
