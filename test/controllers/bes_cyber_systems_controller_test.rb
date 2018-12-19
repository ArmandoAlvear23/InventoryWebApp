require 'test_helper'

class BesCyberSystemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bes_cyber_system = bes_cyber_systems(:one)
  end

  test "should get index" do
    get bes_cyber_systems_url
    assert_response :success
  end

  test "should get new" do
    get new_bes_cyber_system_url
    assert_response :success
  end

  test "should create bes_cyber_system" do
    assert_difference('BesCyberSystem.count') do
      post bes_cyber_systems_url, params: { bes_cyber_system: { BES_asset_BCS: @bes_cyber_system.BES_asset_BCS, BES_cyber_system: @bes_cyber_system.BES_cyber_system, BES_system: @bes_cyber_system.BES_system, impact_rating_BCS: @bes_cyber_system.impact_rating_BCS, justification: @bes_cyber_system.justification } }
    end

    assert_redirected_to bes_cyber_system_url(BesCyberSystem.last)
  end

  test "should show bes_cyber_system" do
    get bes_cyber_system_url(@bes_cyber_system)
    assert_response :success
  end

  test "should get edit" do
    get edit_bes_cyber_system_url(@bes_cyber_system)
    assert_response :success
  end

  test "should update bes_cyber_system" do
    patch bes_cyber_system_url(@bes_cyber_system), params: { bes_cyber_system: { BES_asset_BCS: @bes_cyber_system.BES_asset_BCS, BES_cyber_system: @bes_cyber_system.BES_cyber_system, BES_system: @bes_cyber_system.BES_system, impact_rating_BCS: @bes_cyber_system.impact_rating_BCS, justification: @bes_cyber_system.justification } }
    assert_redirected_to bes_cyber_system_url(@bes_cyber_system)
  end

  test "should destroy bes_cyber_system" do
    assert_difference('BesCyberSystem.count', -1) do
      delete bes_cyber_system_url(@bes_cyber_system)
    end

    assert_redirected_to bes_cyber_systems_url
  end
end
