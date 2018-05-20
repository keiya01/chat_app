class AddNameIdToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :name_id, :string
  end
end
