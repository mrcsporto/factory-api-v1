require "test_helper"

class InventoryCentersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inventory_center = inventory_centers(:one)
  end

  test "should get index" do
    get inventory_centers_url, as: :json
    assert_response :success
  end

  test "should create inventory_center" do
    assert_difference('InventoryCenter.count') do
      post inventory_centers_url, params: { inventory_center: { name: @inventory_center.name } }, as: :json
    end

    assert_response 201
  end

  test "should show inventory_center" do
    get inventory_center_url(@inventory_center), as: :json
    assert_response :success
  end

  test "should update inventory_center" do
    patch inventory_center_url(@inventory_center), params: { inventory_center: { name: @inventory_center.name } }, as: :json
    assert_response 200
  end

  test "should destroy inventory_center" do
    assert_difference('InventoryCenter.count', -1) do
      delete inventory_center_url(@inventory_center), as: :json
    end

    assert_response 204
  end
end
