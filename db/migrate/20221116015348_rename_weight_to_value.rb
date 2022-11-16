class RenameWeightToValue < ActiveRecord::Migration[7.0]
  def change
    rename_column :weights, :weight, :value
  end
end
