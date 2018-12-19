class AddProofToAccessListToEaPoint < ActiveRecord::Migration[5.1]
  def change
    add_column :access_list_to_ea_points, :ea_pproof, :string
  end
end
