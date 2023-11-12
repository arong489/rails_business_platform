json.extract! transaction_item, :id, :transactionOrder_id, :product_id, :number, :created_at, :updated_at
json.url transaction_item_url(transaction_item, format: :json)
