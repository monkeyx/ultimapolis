class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :name
      t.integer :skill_id
      t.integer :total_land, default: 0
      t.integer :free_land, default: 0
      t.integer :transport_capacity, default: 0
      t.integer :civilians, default: 0
      t.integer :automatons, default: 0
      t.integer :unrest, default: 0
      t.integer :health, default: 0
      t.integer :policing, default: 0
      t.integer :social, default: 0
      t.integer :environment, default: 0
      t.integer :housing, default: 0
      t.integer :education, default: 0
      t.integer :community, default: 0
      t.integer :creativity, default: 0
      t.integer :aesthetics, default: 0
      t.integer :crime, default: 0
      t.integer :corruption, default: 0
      t.text :description
      t.string :icon

      t.timestamps null: false
    end

    add_index :districts, :name

    create_table :district_effects do |t|
      t.integer :event_id
      t.integer :district_id
      t.integer :started_on
      t.integer :expires_on
      t.boolean :active, default: true
      t.string :name
      t.text :description
      t.string :icon
      t.integer :total_land, default: 0
      t.integer :transport_capacity, default: 0
      t.integer :civilians, default: 0
      t.integer :automatons, default: 0
      t.integer :unrest, default: 0
      t.integer :health, default: 0
      t.integer :policing, default: 0
      t.integer :social, default: 0
      t.integer :environment, default: 0
      t.integer :housing, default: 0
      t.integer :education, default: 0
      t.integer :community, default: 0
      t.integer :creativity, default: 0
      t.integer :aesthetics, default: 0
      t.integer :crime, default: 0
      t.integer :corruption, default: 0

      t.timestamps null: false
    end
    add_index :district_effects, [:district_id, :active]
    add_index :district_effects, [:district_id, :started_on, :expires_on], name: 'district_effects_turn'
  end
end
