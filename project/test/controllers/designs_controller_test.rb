require "test_helper"

class DesignsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @design = designs(:one)
  end

  test "should get index" do
    get designs_url
    assert_response :success
  end

  test "should get new" do
    get new_design_url
    assert_response :success
  end

  test "should create design" do
    assert_difference("Design.count") do
      post designs_url, params: { design: { name: @design.name, salesVolume: @design.salesVolume } }
    end

    assert_redirected_to design_url(Design.last)
  end

  test "should show design" do
    get design_url(@design)
    assert_response :success
  end

  test "should get edit" do
    get edit_design_url(@design)
    assert_response :success
  end

  test "should update design" do
    patch design_url(@design), params: { design: { name: @design.name, salesVolume: @design.salesVolume } }
    assert_redirected_to design_url(@design)
  end

  test "should destroy design" do
    assert_difference("Design.count", -1) do
      delete design_url(@design)
    end

    assert_redirected_to designs_url
  end
end
