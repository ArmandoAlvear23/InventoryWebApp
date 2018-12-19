class CreatePspDiagramsToPsPerimeters < ActiveRecord::Migration[5.1]
  def change
    create_table :psp_diagrams_to_ps_perimeters do |t|
      t.string :psp_dia_file_name, limit: 225
      t.string :psp_dia_psp_id, limit: 255

      t.timestamps
    end
  end
end
