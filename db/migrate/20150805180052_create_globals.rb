class CreateGlobals < ActiveRecord::Migration
  def change
    create_table :globals do |t|
      t.integer :infrastructure, default: 0
      t.integer :grid, default: 0
      t.integer :power, default: 0
      t.integer :stability, default: 0
      t.integer :climate, default: 0
      t.integer :liberty, default: 0
      t.integer :security, default: 0
      t.integer :borders, default: 0
      t.integer :turn, default: 0
      t.integer :inflation, default: 0
      t.integer :citizens, default: 0
      t.integer :gdp, default: 0

      t.timestamps null: false
    end

    create_table :global_effects do |t|
      t.integer :event_id
      t.integer :started_on
      t.integer :expires_on
      t.boolean :active, default: true
      t.string :name
      t.text :description
      t.string :icon
      t.integer :infrastructure_mod, default: 0
      t.integer :grid_mod, default: 0
      t.integer :power_mod, default: 0
      t.integer :stability_mod, default: 0
      t.integer :climate_mod, default: 0
      t.integer :liberty_mod, default: 0
      t.integer :security_mod, default: 0
      t.integer :borders_mod, default: 0
      t.integer :inflation_mod, default: 0
      
      t.timestamps null: false
    end
    add_index :global_effects, :active
    add_index :global_effects, [:started_on, :expires_on]
  end
end
