class CreateNetworkTopToEsPerimeters < ActiveRecord::Migration[5.1]
  def change
    create_table :network_top_to_es_perimeters do |t|
      t.string :nt_file_name, limit: 255
      t.string :nt_esp_id, limit: 255

      t.timestamps
    end
  end
end
