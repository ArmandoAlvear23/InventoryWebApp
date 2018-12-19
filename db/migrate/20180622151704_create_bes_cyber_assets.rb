class CreateBesCyberAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :bes_cyber_assets do |t|
      t.string :ca_id, limit: 255
      t.string :ca_classification, limit: 255
      t.string :bcs_id, limit: 255
      t.string :impact_rating, limit: 255
      t.string :asset_id, limit: 255
      t.string :protocol, limit: 255
      t.string :ip_address, limit: 255
      t.string :esp_identifier, limit: 255
      t.string :ca_dial_up, limit: 255
      t.string :cip_005, limit: 255
      t.string :ca_ira, limit: 255
      t.string :ca_psp, limit: 255
      t.string :ca_bcs_login, limit: 255
      t.string :bcs_login, limit: 255
      t.string :log_collector, limit: 255
      t.date :activation_date
      t.date :deactivation_date
      t.string :ca_function, limit: 255
      t.string :ca_other, limit: 255
      t.string :ca_vendor, limit: 255
      t.string :ca_model, limit: 255
      t.string :os_firmware, limit: 255
      t.string :os_other, limit: 255
      t.string :external_conn, limit: 255
      t.string :system_logging, limit: 255
      t.string :alerting, limit: 255
      t.string :reg_entity_ncr, limit: 255
      t.string :region, limit: 255
      t.string :function, limit: 255

      t.timestamps
    end
  end
end
