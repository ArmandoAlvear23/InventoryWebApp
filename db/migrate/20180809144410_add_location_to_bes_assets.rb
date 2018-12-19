class AddLocationToBesAssets < ActiveRecord::Migration[5.1]
  def change
    add_column :bes_assets, :location, :string, limit: 255
  end
end
