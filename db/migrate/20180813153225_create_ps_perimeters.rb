class CreatePsPerimeters < ActiveRecord::Migration[5.1]
  def change
    create_table :ps_perimeters do |t|
      t.string :psp_id, limit: 255
      t.string :psp_description, limit: 255
      t.string :psp_location, limit: 255
      t.string :psp_asset_id, limit: 255
      t.string :psp_diagrams, limit: 255

      t.timestamps
    end
  end
end
