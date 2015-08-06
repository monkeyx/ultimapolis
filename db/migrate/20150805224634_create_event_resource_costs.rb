class CreateEventResourceCosts < ActiveRecord::Migration
  def change
    create_table :event_resource_costs do |t|
      t.integer :event_id
      t.integer :trade_good_id
      t.integer :cost

      t.timestamps null: false
    end
    add_index :event_resource_costs, [:event_id, :trade_good_id]
  end
end
