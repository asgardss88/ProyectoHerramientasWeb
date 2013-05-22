class FixColumnName < ActiveRecord::Migration
  def change
     rename_column :questions, :contents, :description
  end
end
