class AddNumberOfElementsToPrompts < ActiveRecord::Migration[7.1]
  def change
    add_column :prompts, :element_count, :integer
    add_column :prompts, :image_size, :string
  end
end
