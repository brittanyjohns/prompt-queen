class CreatePromptTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :prompt_templates do |t|
      t.integer :prompt_template_type
      t.string :name

      t.timestamps
    end
  end
end
