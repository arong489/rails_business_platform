class CreateTransactionItems < ActiveRecord::Migration[7.1]
  def change
    create_table :transaction_items, id: false do |t|
      t.references :transaction_order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :number

      t.timestamps
    end
    add_index(:transaction_items, [:transaction_order_id, :product_id], unique: true)
  end
end
