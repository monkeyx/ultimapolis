class CreateEquipmentTypes < ActiveRecord::Migration
  def change
    create_table :equipment_types do |t|
      t.string :name
      t.integer :facility_type_id
      t.text :description
      t.string :icon
      t.integer :skill_id
      t.integer :skill_modifier
      t.integer :exchange_price

      t.timestamps null: false
    end
    add_index :equipment_types, :facility_type_id
  end
end
