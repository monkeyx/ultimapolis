class CreateEquipmentTypes < ActiveRecord::Migration
  def change
    create_table :equipment_types do |t|
      t.string :name
      t.integer :facility_type_id
      t.text :description
      t.string :icon
      t.integer :skill_id
      t.integer :skill_modifier, default: 0
      t.integer :exchange_price, default: 0
      t.integer :for_sale, default: 0

      t.timestamps null: false
    end
    add_index :equipment_types, :facility_type_id

    create_table :equipment_raw_materials do |t|
      t.integer :equipment_type_id
      t.integer :trade_good_id
      t.integer :quantity, default: 0

      t.timestamps null: false
    end
    add_index :equipment_raw_materials, [:equipment_type_id, :trade_good_id], name: 'erm_mapping'
  end
end
