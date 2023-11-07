require "application_system_test_case"

class DesignsTest < ApplicationSystemTestCase
  setup do
    @design = designs(:one)
  end

  test "visiting the index" do
    visit designs_url
    assert_selector "h1", text: "Designs"
  end

  test "should create design" do
    visit designs_url
    click_on "New design"

    fill_in "Name", with: @design.name
    fill_in "Salesvolume", with: @design.salesVolume
    click_on "Create Design"

    assert_text "Design was successfully created"
    click_on "Back"
  end

  test "should update Design" do
    visit design_url(@design)
    click_on "Edit this design", match: :first

    fill_in "Name", with: @design.name
    fill_in "Salesvolume", with: @design.salesVolume
    click_on "Update Design"

    assert_text "Design was successfully updated"
    click_on "Back"
  end

  test "should destroy Design" do
    visit design_url(@design)
    click_on "Destroy this design", match: :first

    assert_text "Design was successfully destroyed"
  end
end
