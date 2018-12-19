class CreateBesCyberSystems < ActiveRecord::Migration[5.1]
  def change
    create_table :bes_cyber_systems do |t|
      t.string :BES_cyber_system, limit: 255
      t.string :BES_asset_BCS, limit: 255
      t.string :BES_system, limit: 255
      t.string :impact_rating_BCS, limit: 255
      t.string :justification, limit: 255

      t.timestamps
    end
  end
end
