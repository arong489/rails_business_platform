json.extract! transaction_order, :id, :user_id, :consignee, :delivery_address, :delivery_phone, :delivery_postcode, :order_status, :created_at, :updated_at
json.url transaction_order_url(transaction_order, format: :json)
