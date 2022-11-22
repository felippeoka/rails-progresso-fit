class RenameSexToGender < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :sex, :gender
  end
end
