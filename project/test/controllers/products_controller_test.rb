require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: { product: { color_id: @product.color_id, description: @product.description, design_id: @product.design_id, name: @product.name, price: @product.price, sales_volume: @product.sales_volume, size_id: @product.size_id, type_id: @product.type_id } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { color_id: @product.color_id, description: @product.description, design_id: @product.design_id, name: @product.name, price: @product.price, sales_volume: @product.sales_volume, size_id: @product.size_id, type_id: @product.type_id } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
