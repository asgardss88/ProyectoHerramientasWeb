class AddStateToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :state, :boolean
  end
end
