class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.integer :citizen_id
      t.integer :facility_type_id
      t.boolean :powered, default: true
      t.boolean :maintained, default: true
      t.integer :level, default: 1
      t.integer :producing_trade_good_id
      t.integer :producing_equipment_type_id

      t.timestamps null: false
    end
    add_index :facilities, [:citizen_id, :facility_type_id]
  end
end
