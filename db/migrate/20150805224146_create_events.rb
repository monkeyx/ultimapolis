class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :event_type
      t.integer :trigger_after_event_id
      t.integer :started_on
      t.integer :finished_on
      t.integer :max_duration, default: 0
      t.boolean :current, default: true
      t.boolean :success, default: false
      t.text :summary
      t.text :description
      t.integer :winning_project_id
      t.string :icon

      t.timestamps null: false
    end
    add_index :events, [:event_type, :current]
    add_index :events, [:started_on, :finished_on, :success]

    create_table :event_skill_costs do |t|
      t.integer :event_id
      t.integer :skill_id
      t.integer :cost, default: 0

      t.timestamps null: false
    end
    add_index :event_skill_costs, [:event_id, :skill_id]

    create_table :event_resource_costs do |t|
      t.integer :event_id
      t.integer :trade_good_id
      t.integer :cost, default: 0

      t.timestamps null: false
    end
    add_index :event_resource_costs, [:event_id, :trade_good_id]

    create_table :event_rewards do |t|
      t.integer :event_id
      t.integer :trade_good_id
      t.integer :equipment_type_id
      t.integer :facility_type_id
      t.boolean :credits, default: false
      t.integer :quantity, default: 0

      t.timestamps null: false
    end
    add_index :event_rewards, :event_id
  end
end
