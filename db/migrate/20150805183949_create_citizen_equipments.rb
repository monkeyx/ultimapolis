class CreateCitizenEquipments < ActiveRecord::Migration
  def change
    create_table :citizen_equipments do |t|
      t.integer :citizen_id
      t.integer :equipment_type_id
      t.integer :quantity

      t.timestamps null: false
    end
    add_index :citizen_equipments, [:citizen_id, :equipment_type_id]
  end
end
