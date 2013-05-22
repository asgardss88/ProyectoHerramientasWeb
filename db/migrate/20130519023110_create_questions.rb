class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :user, index: true
      t.text :contents
      t.integer :votes
      t.integer :bonus

      t.timestamps
    end
  end
end
