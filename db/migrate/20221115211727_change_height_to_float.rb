class ChangeHeightToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :height, :float
  end
end
