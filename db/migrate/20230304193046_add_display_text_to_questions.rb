class AddDisplayTextToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :display_name, :string
    add_column :prompt_templates, :prefix_text, :text
    rename_column :prompts, :answers, :template_answers
  end
end
