class AddPasswordDigestToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :password_digest, :string
  end
end
