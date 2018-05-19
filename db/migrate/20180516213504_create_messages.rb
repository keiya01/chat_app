class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.string :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
