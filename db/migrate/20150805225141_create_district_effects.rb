class CreateDistrictEffects < ActiveRecord::Migration
  def change
    create_table :district_effects do |t|
      t.integer :event_id
      t.integer :district_id
      t.integer :started_on
      t.integer :expires_on
      t.boolean :active
      t.string :name
      t.text :description
      t.string :icon
      t.integer :total_land
      t.integer :transport_capacity
      t.integer :civilians
      t.integer :automatons
      t.integer :unrest
      t.integer :health
      t.integer :policing
      t.integer :social
      t.integer :environment
      t.integer :housing
      t.integer :education
      t.integer :community
      t.integer :creativity
      t.integer :aesthetics
      t.integer :crime
      t.integer :corruption

      t.timestamps null: false
    end
    add_index :district_effects, [:district_id, :active]
    add_index :district_effects, [:district_id, :started_on, :expires_on], name: 'district_effects_turn'
  end
end
