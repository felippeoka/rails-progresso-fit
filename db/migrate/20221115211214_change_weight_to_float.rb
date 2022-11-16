class ChangeWeightToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :weights, :weight, :float
  end
end
