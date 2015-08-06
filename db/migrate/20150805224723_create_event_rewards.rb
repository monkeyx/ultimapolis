class CreateEventRewards < ActiveRecord::Migration
  def change
    create_table :event_rewards do |t|
      t.integer :event_id
      t.integer :trade_good_id
      t.integer :equipment_type_id
      t.integer :facility_id
      t.boolean :credits, default: false
      t.integer :quantity

      t.timestamps null: false
    end
    add_index :event_rewards, :event_id
  end
end
