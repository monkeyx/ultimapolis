class CreateEventSkillCosts < ActiveRecord::Migration
  def change
    create_table :event_skill_costs do |t|
      t.integer :event_id
      t.integer :skill_id
      t.integer :cost

      t.timestamps null: false
    end
    add_index :event_skill_costs, [:event_id, :skill_id]
  end
end
