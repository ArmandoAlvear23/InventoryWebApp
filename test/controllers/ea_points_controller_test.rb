require 'test_helper'

class EaPointsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ea_point = ea_points(:one)
  end

  test "should get index" do
    get ea_points_url
    assert_response :success
  end

  test "should get new" do
    get new_ea_point_url
    assert_response :success
  end

  test "should create ea_point" do
    assert_difference('EaPoint.count') do
      post ea_points_url, params: { ea_point: { eap_access_list: @ea_point.eap_access_list, eap_ca_eacms: @ea_point.eap_ca_eacms, eap_esp_id: @ea_point.eap_esp_id, eap_id: @ea_point.eap_id, eap_interface: @ea_point.eap_interface, eap_ip: @ea_point.eap_ip } }
    end

    assert_redirected_to ea_point_url(EaPoint.last)
  end

  test "should show ea_point" do
    get ea_point_url(@ea_point)
    assert_response :success
  end

  test "should get edit" do
    get edit_ea_point_url(@ea_point)
    assert_response :success
  end

  test "should update ea_point" do
    patch ea_point_url(@ea_point), params: { ea_point: { eap_access_list: @ea_point.eap_access_list, eap_ca_eacms: @ea_point.eap_ca_eacms, eap_esp_id: @ea_point.eap_esp_id, eap_id: @ea_point.eap_id, eap_interface: @ea_point.eap_interface, eap_ip: @ea_point.eap_ip } }
    assert_redirected_to ea_point_url(@ea_point)
  end

  test "should destroy ea_point" do
    assert_difference('EaPoint.count', -1) do
      delete ea_point_url(@ea_point)
    end

    assert_redirected_to ea_points_url
  end
end
