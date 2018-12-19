require 'test_helper'

class NetworkTopToEsPerimetersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @network_top_to_es_perimeter = network_top_to_es_perimeters(:one)
  end

  test "should get index" do
    get network_top_to_es_perimeters_url
    assert_response :success
  end

  test "should get new" do
    get new_network_top_to_es_perimeter_url
    assert_response :success
  end

  test "should create network_top_to_es_perimeter" do
    assert_difference('NetworkTopToEsPerimeter.count') do
      post network_top_to_es_perimeters_url, params: { network_top_to_es_perimeter: { nt_esp_id: @network_top_to_es_perimeter.nt_esp_id, nt_file_name: @network_top_to_es_perimeter.nt_file_name } }
    end

    assert_redirected_to network_top_to_es_perimeter_url(NetworkTopToEsPerimeter.last)
  end

  test "should show network_top_to_es_perimeter" do
    get network_top_to_es_perimeter_url(@network_top_to_es_perimeter)
    assert_response :success
  end

  test "should get edit" do
    get edit_network_top_to_es_perimeter_url(@network_top_to_es_perimeter)
    assert_response :success
  end

  test "should update network_top_to_es_perimeter" do
    patch network_top_to_es_perimeter_url(@network_top_to_es_perimeter), params: { network_top_to_es_perimeter: { nt_esp_id: @network_top_to_es_perimeter.nt_esp_id, nt_file_name: @network_top_to_es_perimeter.nt_file_name } }
    assert_redirected_to network_top_to_es_perimeter_url(@network_top_to_es_perimeter)
  end

  test "should destroy network_top_to_es_perimeter" do
    assert_difference('NetworkTopToEsPerimeter.count', -1) do
      delete network_top_to_es_perimeter_url(@network_top_to_es_perimeter)
    end

    assert_redirected_to network_top_to_es_perimeters_url
  end
end
