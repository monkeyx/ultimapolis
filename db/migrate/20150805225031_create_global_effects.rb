class CreateGlobalEffects < ActiveRecord::Migration
  def change
    create_table :global_effects do |t|
      t.integer :event_id
      t.integer :started_on
      t.integer :expires_on
      t.boolean :active
      t.string :name
      t.text :description
      t.string :icon
      t.integer :infrastructure_mod
      t.integer :grid_mod
      t.integer :power_mod
      t.integer :stability_mod
      t.integer :climate_mod
      t.integer :liberty_mod
      t.integer :security_mod
      t.integer :borders_mod
      t.integer :inflation_mod
      
      t.timestamps null: false
    end
    add_index :global_effects, :active
    add_index :global_effects, [:started_on, :expires_on]
  end
end
