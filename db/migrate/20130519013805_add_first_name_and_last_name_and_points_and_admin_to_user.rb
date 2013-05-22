class AddFirstNameAndLastNameAndPointsAndAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :points, :integer, default: 0
    add_column :users, :admin, :boolean, default: false
  end
end