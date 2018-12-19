class CreateEsPerimeters < ActiveRecord::Migration[5.1]
  def change
    create_table :es_perimeters do |t|
      t.string :esp_id, limit: 255
      t.string :esp_description, limit: 255
      t.string :esp_network, limit: 255
      t.string :esp_conn, limit: 255
      t.string :esp_remote, limit: 255
      t.string :esp_eacms, limit: 255
      t.string :esp_topology, limit: 255

      t.timestamps
    end
  end
end
