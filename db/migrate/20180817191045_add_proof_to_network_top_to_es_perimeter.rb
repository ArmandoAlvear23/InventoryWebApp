class AddProofToNetworkTopToEsPerimeter < ActiveRecord::Migration[5.1]
  def change
    add_column :network_top_to_es_perimeters, :es_pproof, :string
  end
end
