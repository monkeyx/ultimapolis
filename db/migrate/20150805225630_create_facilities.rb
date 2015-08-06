class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.integer :citizen_id
      t.integer :facility_type_id
      t.boolean :powered
      t.boolean :maintained
      t.integer :utilised
      t.integer :level

      t.timestamps null: false
    end
    add_index :facilities, [:citizen_id, :facility_type_id]
  end
end
