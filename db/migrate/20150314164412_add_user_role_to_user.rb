class AddUserRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_role, :integer, default: 0
  end
end
