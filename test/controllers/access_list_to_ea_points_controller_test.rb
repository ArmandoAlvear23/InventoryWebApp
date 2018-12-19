require 'test_helper'

class AccessListToEaPointsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @access_list_to_ea_point = access_list_to_ea_points(:one)
  end

  test "should get index" do
    get access_list_to_ea_points_url
    assert_response :success
  end

  test "should get new" do
    get new_access_list_to_ea_point_url
    assert_response :success
  end

  test "should create access_list_to_ea_point" do
    assert_difference('AccessListToEaPoint.count') do
      post access_list_to_ea_points_url, params: { access_list_to_ea_point: { al_eap_id: @access_list_to_ea_point.al_eap_id, al_file_name: @access_list_to_ea_point.al_file_name } }
    end

    assert_redirected_to access_list_to_ea_point_url(AccessListToEaPoint.last)
  end

  test "should show access_list_to_ea_point" do
    get access_list_to_ea_point_url(@access_list_to_ea_point)
    assert_response :success
  end

  test "should get edit" do
    get edit_access_list_to_ea_point_url(@access_list_to_ea_point)
    assert_response :success
  end

  test "should update access_list_to_ea_point" do
    patch access_list_to_ea_point_url(@access_list_to_ea_point), params: { access_list_to_ea_point: { al_eap_id: @access_list_to_ea_point.al_eap_id, al_file_name: @access_list_to_ea_point.al_file_name } }
    assert_redirected_to access_list_to_ea_point_url(@access_list_to_ea_point)
  end

  test "should destroy access_list_to_ea_point" do
    assert_difference('AccessListToEaPoint.count', -1) do
      delete access_list_to_ea_point_url(@access_list_to_ea_point)
    end

    assert_redirected_to access_list_to_ea_points_url
  end
end
