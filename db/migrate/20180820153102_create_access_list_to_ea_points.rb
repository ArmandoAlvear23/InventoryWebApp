class CreateAccessListToEaPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :access_list_to_ea_points do |t|
      t.string :al_file_name, limit: 255
      t.string :al_eap_id, limit: 255

      t.timestamps
    end
  end
end
