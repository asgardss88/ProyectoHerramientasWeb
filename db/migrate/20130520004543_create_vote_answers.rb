class CreateVoteAnswers < ActiveRecord::Migration
  def change
    create_table :vote_answers do |t|
      t.references :user, index: true
      t.references :answer, index: true

      t.timestamps
    end
  end
end
