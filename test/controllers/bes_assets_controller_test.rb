require 'test_helper'

class BesAssetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bes_asset = bes_assets(:one)
  end

  test "should get index" do
    get bes_assets_url
    assert_response :success
  end

  test "should get new" do
    get new_bes_asset_url
    assert_response :success
  end

  test "should create bes_asset" do
    assert_difference('BesAsset.count') do
      post bes_assets_url, params: { bes_asset: { aa1: @bes_asset.aa1, aa2: @bes_asset.aa2, aa3: @bes_asset.aa3, asset_id: @bes_asset.asset_id, asset_type: @bes_asset.asset_type, cc1: @bes_asset.cc1, cc2: @bes_asset.cc2, cc3: @bes_asset.cc3, cc4: @bes_asset.cc4, cc5: @bes_asset.cc5, cc6: @bes_asset.cc6, cc7: @bes_asset.cc7, cc8: @bes_asset.cc8, commission: @bes_asset.commission, decommission: @bes_asset.decommission, description: @bes_asset.description, dial_up: @bes_asset.dial_up, dp1: @bes_asset.dp1, erc: @bes_asset.erc, g1: @bes_asset.g1, g2: @bes_asset.g2, g3: @bes_asset.g3, g4: @bes_asset.g4, g5: @bes_asset.g5, high_impact: @bes_asset.high_impact, low_impact: @bes_asset.low_impact, medium_impact: @bes_asset.medium_impact, region_op: @bes_asset.region_op, register_func: @bes_asset.register_func, tf1: @bes_asset.tf1, tf2: @bes_asset.tf2, tf3: @bes_asset.tf3, tf4: @bes_asset.tf4, tf5: @bes_asset.tf5, tf6: @bes_asset.tf6, tf7: @bes_asset.tf7, tf8: @bes_asset.tf8 } }
    end

    assert_redirected_to bes_asset_url(BesAsset.last)
  end

  test "should show bes_asset" do
    get bes_asset_url(@bes_asset)
    assert_response :success
  end

  test "should get edit" do
    get edit_bes_asset_url(@bes_asset)
    assert_response :success
  end

  test "should update bes_asset" do
    patch bes_asset_url(@bes_asset), params: { bes_asset: { aa1: @bes_asset.aa1, aa2: @bes_asset.aa2, aa3: @bes_asset.aa3, asset_id: @bes_asset.asset_id, asset_type: @bes_asset.asset_type, cc1: @bes_asset.cc1, cc2: @bes_asset.cc2, cc3: @bes_asset.cc3, cc4: @bes_asset.cc4, cc5: @bes_asset.cc5, cc6: @bes_asset.cc6, cc7: @bes_asset.cc7, cc8: @bes_asset.cc8, commission: @bes_asset.commission, decommission: @bes_asset.decommission, description: @bes_asset.description, dial_up: @bes_asset.dial_up, dp1: @bes_asset.dp1, erc: @bes_asset.erc, g1: @bes_asset.g1, g2: @bes_asset.g2, g3: @bes_asset.g3, g4: @bes_asset.g4, g5: @bes_asset.g5, high_impact: @bes_asset.high_impact, low_impact: @bes_asset.low_impact, medium_impact: @bes_asset.medium_impact, region_op: @bes_asset.region_op, register_func: @bes_asset.register_func, tf1: @bes_asset.tf1, tf2: @bes_asset.tf2, tf3: @bes_asset.tf3, tf4: @bes_asset.tf4, tf5: @bes_asset.tf5, tf6: @bes_asset.tf6, tf7: @bes_asset.tf7, tf8: @bes_asset.tf8 } }
    assert_redirected_to bes_asset_url(@bes_asset)
  end

  test "should destroy bes_asset" do
    assert_difference('BesAsset.count', -1) do
      delete bes_asset_url(@bes_asset)
    end

    assert_redirected_to bes_assets_url
  end
end
