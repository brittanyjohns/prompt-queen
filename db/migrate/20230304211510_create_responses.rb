class CreateResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :responses do |t|
      t.belongs_to :prompt, null: false, foreign_key: true
      t.string :created_by
      t.text :prompt_text
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
