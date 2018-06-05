class AddQuestionAndAnswerColumnToGroups < ActiveRecord::Migration[5.1]
  def change
  	add_column :groups, :question, :string
  	add_column :groups, :answer, :string
  	remove_column :groups, :password_digest, :string
  	remove_column :groups, :name_id, :string
  end
end
