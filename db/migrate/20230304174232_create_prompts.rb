class CreatePrompts < ActiveRecord::Migration[7.1]
  def change
    create_table :prompts do |t|
      t.belongs_to :prompt_template, null: false, foreign_key: true
      t.text :body
      t.integer :created_by
      t.datetime :sent_at

      t.timestamps
    end
  end
end
