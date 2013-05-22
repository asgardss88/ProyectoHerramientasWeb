class CreateAssignedTags < ActiveRecord::Migration
  def change
    create_table :assigned_tags do |t|
      t.references :question, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end
