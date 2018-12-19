class AddProofToBesCyberAsset < ActiveRecord::Migration[5.1]
  def change
    add_column :bes_cyber_assets, :proof, :string
  end
end
