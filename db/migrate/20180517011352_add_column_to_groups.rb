class AddColumnToGroups < ActiveRecord::Migration[5.1]
  def change
  	add_column :groups, :entry_pass, :string
  	remove_column :groups, :password, :string
  end
end
