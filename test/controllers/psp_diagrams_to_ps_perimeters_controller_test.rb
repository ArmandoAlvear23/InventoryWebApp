require 'test_helper'

class PspDiagramsToPsPerimetersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @psp_diagrams_to_ps_perimeter = psp_diagrams_to_ps_perimeters(:one)
  end

  test "should get index" do
    get psp_diagrams_to_ps_perimeters_url
    assert_response :success
  end

  test "should get new" do
    get new_psp_diagrams_to_ps_perimeter_url
    assert_response :success
  end

  test "should create psp_diagrams_to_ps_perimeter" do
    assert_difference('PspDiagramsToPsPerimeter.count') do
      post psp_diagrams_to_ps_perimeters_url, params: { psp_diagrams_to_ps_perimeter: { psp_dia_file_name: @psp_diagrams_to_ps_perimeter.psp_dia_file_name, psp_dia_psp_id: @psp_diagrams_to_ps_perimeter.psp_dia_psp_id } }
    end

    assert_redirected_to psp_diagrams_to_ps_perimeter_url(PspDiagramsToPsPerimeter.last)
  end

  test "should show psp_diagrams_to_ps_perimeter" do
    get psp_diagrams_to_ps_perimeter_url(@psp_diagrams_to_ps_perimeter)
    assert_response :success
  end

  test "should get edit" do
    get edit_psp_diagrams_to_ps_perimeter_url(@psp_diagrams_to_ps_perimeter)
    assert_response :success
  end

  test "should update psp_diagrams_to_ps_perimeter" do
    patch psp_diagrams_to_ps_perimeter_url(@psp_diagrams_to_ps_perimeter), params: { psp_diagrams_to_ps_perimeter: { psp_dia_file_name: @psp_diagrams_to_ps_perimeter.psp_dia_file_name, psp_dia_psp_id: @psp_diagrams_to_ps_perimeter.psp_dia_psp_id } }
    assert_redirected_to psp_diagrams_to_ps_perimeter_url(@psp_diagrams_to_ps_perimeter)
  end

  test "should destroy psp_diagrams_to_ps_perimeter" do
    assert_difference('PspDiagramsToPsPerimeter.count', -1) do
      delete psp_diagrams_to_ps_perimeter_url(@psp_diagrams_to_ps_perimeter)
    end

    assert_redirected_to psp_diagrams_to_ps_perimeters_url
  end
end
