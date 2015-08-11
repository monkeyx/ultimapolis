class CreateExchangeEquipments < ActiveRecord::Migration
  def change
    create_table :exchange_equipments do |t|
      t.integer :equipment_type_id
      t.integer :citizen_id
      t.integer :turn
      t.integer :price
      t.integer :quantity

      t.timestamps null: false
    end
    add_index :exchange_equipments, [:equipment_type_id, :citizen_id, :turn], name: 'idx_exchange_equipment'
  end
end
