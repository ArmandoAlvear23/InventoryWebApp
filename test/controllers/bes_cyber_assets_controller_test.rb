require 'test_helper'

class BesCyberAssetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bes_cyber_asset = bes_cyber_assets(:one)
  end

  test "should get index" do
    get bes_cyber_assets_url
    assert_response :success
  end

  test "should get new" do
    get new_bes_cyber_asset_url
    assert_response :success
  end

  test "should create bes_cyber_asset" do
    assert_difference('BesCyberAsset.count') do
      post bes_cyber_assets_url, params: { bes_cyber_asset: { activation_date: @bes_cyber_asset.activation_date, alerting: @bes_cyber_asset.alerting, asset_id: @bes_cyber_asset.asset_id, bcs_id: @bes_cyber_asset.bcs_id, bcs_login: @bes_cyber_asset.bcs_login, ca_bcs_login: @bes_cyber_asset.ca_bcs_login, ca_classification: @bes_cyber_asset.ca_classification, ca_dial_up: @bes_cyber_asset.ca_dial_up, ca_function: @bes_cyber_asset.ca_function, ca_id: @bes_cyber_asset.ca_id, ca_ira: @bes_cyber_asset.ca_ira, ca_model: @bes_cyber_asset.ca_model, ca_other: @bes_cyber_asset.ca_other, ca_psp: @bes_cyber_asset.ca_psp, ca_vendor: @bes_cyber_asset.ca_vendor, cip_005: @bes_cyber_asset.cip_005, deactivation_date: @bes_cyber_asset.deactivation_date, esp_identifier: @bes_cyber_asset.esp_identifier, external_conn: @bes_cyber_asset.external_conn, function: @bes_cyber_asset.function, impact_rating: @bes_cyber_asset.impact_rating, ip_address: @bes_cyber_asset.ip_address, log_collector: @bes_cyber_asset.log_collector, os_firmware: @bes_cyber_asset.os_firmware, os_other: @bes_cyber_asset.os_other, protocol: @bes_cyber_asset.protocol, reg_entity_ncr: @bes_cyber_asset.reg_entity_ncr, region: @bes_cyber_asset.region, system_logging: @bes_cyber_asset.system_logging } }
    end

    assert_redirected_to bes_cyber_asset_url(BesCyberAsset.last)
  end

  test "should show bes_cyber_asset" do
    get bes_cyber_asset_url(@bes_cyber_asset)
    assert_response :success
  end

  test "should get edit" do
    get edit_bes_cyber_asset_url(@bes_cyber_asset)
    assert_response :success
  end

  test "should update bes_cyber_asset" do
    patch bes_cyber_asset_url(@bes_cyber_asset), params: { bes_cyber_asset: { activation_date: @bes_cyber_asset.activation_date, alerting: @bes_cyber_asset.alerting, asset_id: @bes_cyber_asset.asset_id, bcs_id: @bes_cyber_asset.bcs_id, bcs_login: @bes_cyber_asset.bcs_login, ca_bcs_login: @bes_cyber_asset.ca_bcs_login, ca_classification: @bes_cyber_asset.ca_classification, ca_dial_up: @bes_cyber_asset.ca_dial_up, ca_function: @bes_cyber_asset.ca_function, ca_id: @bes_cyber_asset.ca_id, ca_ira: @bes_cyber_asset.ca_ira, ca_model: @bes_cyber_asset.ca_model, ca_other: @bes_cyber_asset.ca_other, ca_psp: @bes_cyber_asset.ca_psp, ca_vendor: @bes_cyber_asset.ca_vendor, cip_005: @bes_cyber_asset.cip_005, deactivation_date: @bes_cyber_asset.deactivation_date, esp_identifier: @bes_cyber_asset.esp_identifier, external_conn: @bes_cyber_asset.external_conn, function: @bes_cyber_asset.function, impact_rating: @bes_cyber_asset.impact_rating, ip_address: @bes_cyber_asset.ip_address, log_collector: @bes_cyber_asset.log_collector, os_firmware: @bes_cyber_asset.os_firmware, os_other: @bes_cyber_asset.os_other, protocol: @bes_cyber_asset.protocol, reg_entity_ncr: @bes_cyber_asset.reg_entity_ncr, region: @bes_cyber_asset.region, system_logging: @bes_cyber_asset.system_logging } }
    assert_redirected_to bes_cyber_asset_url(@bes_cyber_asset)
  end

  test "should destroy bes_cyber_asset" do
    assert_difference('BesCyberAsset.count', -1) do
      delete bes_cyber_asset_url(@bes_cyber_asset)
    end

    assert_redirected_to bes_cyber_assets_url
  end
end
