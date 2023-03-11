class AddTypeToAnswers < ActiveRecord::Migration[7.1]
  def change
    add_column :answers, :answer_type, :integer
  end
end
