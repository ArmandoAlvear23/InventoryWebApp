class AddColumnsToBesCyberSystems < ActiveRecord::Migration[5.1]
  def change
    add_column :bes_cyber_systems, :q1, :string, limit: 255
    add_column :bes_cyber_systems, :q2, :string, limit: 255
    add_column :bes_cyber_systems, :q3, :string, limit: 255
    add_column :bes_cyber_systems, :q4, :string, limit: 255
    add_column :bes_cyber_systems, :q5, :string, limit: 255
    add_column :bes_cyber_systems, :q6, :string, limit: 255
    add_column :bes_cyber_systems, :q7, :string, limit: 255
    add_column :bes_cyber_systems, :q8, :string, limit: 255
    add_column :bes_cyber_systems, :q9, :string, limit: 255
  end
end
