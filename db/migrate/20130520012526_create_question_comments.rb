class CreateQuestionComments < ActiveRecord::Migration
  def change
    create_table :question_comments do |t|
      t.references :user, index: true
      t.references :question, index: true
      t.text :content

      t.timestamps
    end
  end
end
