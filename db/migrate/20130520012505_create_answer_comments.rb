class CreateAnswerComments < ActiveRecord::Migration
  def change
    create_table :answer_comments do |t|
      t.references :user, index: true
      t.references :answer, index: true
      t.text :content

      t.timestamps
    end
  end
end
