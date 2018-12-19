class AddProofToBesAsset < ActiveRecord::Migration[5.1]
  def change
    add_column :bes_assets, :proof, :string
  end
end
