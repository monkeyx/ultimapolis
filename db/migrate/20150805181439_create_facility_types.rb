class CreateFacilityTypes < ActiveRecord::Migration
  def change
    create_table :facility_types do |t|
      t.string :name
      t.integer :district_id
      t.text :description
      t.string :icon
      t.integer :build_cost, default: 1000
      t.integer :maintenance_cost, default: 100
      t.integer :employees, default: 10
      t.integer :automation, default: 50
      t.integer :power_consumption, default: 1
      t.integer :power_generation, default: 0
      t.integer :pollution, default: 0
      t.integer :housing_mod, default: 0
      
      t.timestamps null: false
    end
    add_index :facility_types, :district_id
  end
end
