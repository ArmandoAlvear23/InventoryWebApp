require 'test_helper'

class EsPerimetersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @es_perimeter = es_perimeters(:one)
  end

  test "should get index" do
    get es_perimeters_url
    assert_response :success
  end

  test "should get new" do
    get new_es_perimeter_url
    assert_response :success
  end

  test "should create es_perimeter" do
    assert_difference('EsPerimeter.count') do
      post es_perimeters_url, params: { es_perimeter: { esp_conn: @es_perimeter.esp_conn, esp_description: @es_perimeter.esp_description, esp_eacms: @es_perimeter.esp_eacms, esp_id: @es_perimeter.esp_id, esp_network: @es_perimeter.esp_network, esp_remote: @es_perimeter.esp_remote, esp_topology: @es_perimeter.esp_topology } }
    end

    assert_redirected_to es_perimeter_url(EsPerimeter.last)
  end

  test "should show es_perimeter" do
    get es_perimeter_url(@es_perimeter)
    assert_response :success
  end

  test "should get edit" do
    get edit_es_perimeter_url(@es_perimeter)
    assert_response :success
  end

  test "should update es_perimeter" do
    patch es_perimeter_url(@es_perimeter), params: { es_perimeter: { esp_conn: @es_perimeter.esp_conn, esp_description: @es_perimeter.esp_description, esp_eacms: @es_perimeter.esp_eacms, esp_id: @es_perimeter.esp_id, esp_network: @es_perimeter.esp_network, esp_remote: @es_perimeter.esp_remote, esp_topology: @es_perimeter.esp_topology } }
    assert_redirected_to es_perimeter_url(@es_perimeter)
  end

  test "should destroy es_perimeter" do
    assert_difference('EsPerimeter.count', -1) do
      delete es_perimeter_url(@es_perimeter)
    end

    assert_redirected_to es_perimeters_url
  end
end
