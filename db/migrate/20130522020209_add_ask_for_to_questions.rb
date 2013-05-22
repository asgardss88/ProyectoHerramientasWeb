class AddAskForToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :ask_for, :string
  end
end
