class AddAnswersToPrompts < ActiveRecord::Migration[7.1]
  def change
    add_column :prompts, :answers, :json
  end
end
