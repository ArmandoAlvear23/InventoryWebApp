class AddProofToPspDiagramsToPsPerimeter < ActiveRecord::Migration[5.1]
  def change
    add_column :psp_diagrams_to_ps_perimeters, :ps_pproof, :string
  end
end
