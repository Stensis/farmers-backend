require "application_system_test_case"

class FarmersTest < ApplicationSystemTestCase
  setup do
    @farmer = farmers(:one)
  end

  test "visiting the index" do
    visit farmers_url
    assert_selector "h1", text: "Farmers"
  end

  test "should create farmer" do
    visit farmers_url
    click_on "New farmer"

    fill_in "Email", with: @farmer.email
    fill_in "Full name", with: @farmer.full_name
    fill_in "Location", with: @farmer.location
    fill_in "Tel", with: @farmer.tel
    click_on "Create Farmer"

    assert_text "Farmer was successfully created"
    click_on "Back"
  end

  test "should update Farmer" do
    visit farmer_url(@farmer)
    click_on "Edit this farmer", match: :first

    fill_in "Email", with: @farmer.email
    fill_in "Full name", with: @farmer.full_name
    fill_in "Location", with: @farmer.location
    fill_in "Tel", with: @farmer.tel
    click_on "Update Farmer"

    assert_text "Farmer was successfully updated"
    click_on "Back"
  end

  test "should destroy Farmer" do
    visit farmer_url(@farmer)
    click_on "Destroy this farmer", match: :first

    assert_text "Farmer was successfully destroyed"
  end
end
