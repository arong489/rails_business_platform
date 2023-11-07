class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name,:null => false
      t.decimal :price
      t.text :description
      t.integer :sales_volume
      t.references :design, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true
      t.references :type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
