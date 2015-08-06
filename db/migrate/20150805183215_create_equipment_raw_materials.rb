class CreateEquipmentRawMaterials < ActiveRecord::Migration
  def change
    create_table :equipment_raw_materials do |t|
      t.integer :equipment_type_id
      t.integer :trade_good_id
      t.integer :quantity

      t.timestamps null: false
    end
    add_index :equipment_raw_materials, [:equipment_type_id, :trade_good_id], name: 'erm_mapping'
  end
end
