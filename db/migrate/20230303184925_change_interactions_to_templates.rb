class ChangeInteractionsToTemplates < ActiveRecord::Migration[7.1]
  def change
    rename_table :interactions, :prompt_templates
  end
end
