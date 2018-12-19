require 'test_helper'

class PsPerimetersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ps_perimeter = ps_perimeters(:one)
  end

  test "should get index" do
    get ps_perimeters_url
    assert_response :success
  end

  test "should get new" do
    get new_ps_perimeter_url
    assert_response :success
  end

  test "should create ps_perimeter" do
    assert_difference('PsPerimeter.count') do
      post ps_perimeters_url, params: { ps_perimeter: { psp_asset_id: @ps_perimeter.psp_asset_id, psp_description: @ps_perimeter.psp_description, psp_diagrams: @ps_perimeter.psp_diagrams, psp_id: @ps_perimeter.psp_id, psp_location: @ps_perimeter.psp_location } }
    end

    assert_redirected_to ps_perimeter_url(PsPerimeter.last)
  end

  test "should show ps_perimeter" do
    get ps_perimeter_url(@ps_perimeter)
    assert_response :success
  end

  test "should get edit" do
    get edit_ps_perimeter_url(@ps_perimeter)
    assert_response :success
  end

  test "should update ps_perimeter" do
    patch ps_perimeter_url(@ps_perimeter), params: { ps_perimeter: { psp_asset_id: @ps_perimeter.psp_asset_id, psp_description: @ps_perimeter.psp_description, psp_diagrams: @ps_perimeter.psp_diagrams, psp_id: @ps_perimeter.psp_id, psp_location: @ps_perimeter.psp_location } }
    assert_redirected_to ps_perimeter_url(@ps_perimeter)
  end

  test "should destroy ps_perimeter" do
    assert_difference('PsPerimeter.count', -1) do
      delete ps_perimeter_url(@ps_perimeter)
    end

    assert_redirected_to ps_perimeters_url
  end
end
