class ChangeInteractionsToTemplatesFields < ActiveRecord::Migration[7.1]
  def change
    rename_column :prompt_templates, :interaction_type, :prompt_template_type
    rename_column :questions, :interaction_id, :prompt_template_id
  end
end
