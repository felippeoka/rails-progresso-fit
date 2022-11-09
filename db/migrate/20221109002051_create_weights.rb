class CreateWeights < ActiveRecord::Migration[7.0]
  def change
    create_table :weights do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :weight

      t.timestamps
    end
  end
end
