class CreateEaPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :ea_points do |t|
      t.string :eap_id, limit: 255
      t.string :eap_interface, limit: 255
      t.string :eap_ip, limit: 255
      t.string :eap_ca_eacms, limit: 255
      t.string :eap_esp_id, limit: 255
      t.string :eap_access_list, limit: 255

      t.timestamps
    end
  end
end
