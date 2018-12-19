class CreateBesAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :bes_assets do |t|
      t.string :asset_id, limit: 255
      t.string :asset_type, limit: 255
      t.string :description, limit: 255
      t.date :commission
      t.date :decommission
      t.string :high_impact, limit: 255
      t.string :medium_impact, limit: 255
      t.string :low_impact, limit: 255
      t.string :erc, limit: 255
      t.string :dial_up, limit: 255
      t.string :region_op, limit: 255
      t.string :register_func, limit: 255
      t.string :cc1, limit: 255
      t.string :cc2, limit: 255
      t.string :cc3, limit: 255
      t.string :cc4, limit: 255
      t.string :cc5, limit: 255
      t.string :cc6, limit: 255
      t.string :cc7, limit: 255
      t.string :cc8, limit: 255
      t.string :tf1, limit: 255
      t.string :tf2, limit: 255
      t.string :tf3, limit: 255
      t.string :tf4, limit: 255
      t.string :tf5, limit: 255
      t.string :tf6, limit: 255
      t.string :tf7, limit: 255
      t.string :tf8, limit: 255
      t.string :g1, limit: 255
      t.string :g2, limit: 255
      t.string :g3, limit: 255
      t.string :g4, limit: 255
      t.string :g5, limit: 255
      t.string :aa1, limit: 255
      t.string :aa2, limit: 255
      t.string :aa3, limit: 255
      t.string :dp1, limit: 255

      t.timestamps
    end
  end
end
