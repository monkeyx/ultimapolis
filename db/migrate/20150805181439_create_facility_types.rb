class CreateFacilityTypes < ActiveRecord::Migration
  def change
    create_table :facility_types do |t|
      t.string :name
      t.integer :district_id
      t.text :description
      t.string :icon
      t.integer :build_cost
      t.integer :maintenance_cost
      t.integer :employees
      t.integer :automation
      t.integer :power_consumption
      t.integer :power_generation
      t.integer :pollution

      t.timestamps null: false
    end
    add_index :facility_types, :district_id
  end
end
