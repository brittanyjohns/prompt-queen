class CreateInteractions < ActiveRecord::Migration[7.1]
  def change
    create_table :interactions do |t|
      t.string :name
      t.integer :type
      t.integer :user_id

      t.timestamps
    end
  end
end
