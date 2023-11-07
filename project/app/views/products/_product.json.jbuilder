json.extract! product, :id, :name, :price, :description, :sales_volume, :design_id, :color_id, :size_id, :type_id, :created_at, :updated_at
json.url product_url(product, format: :json)
