class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :leader_id
      t.integer :event_id
      t.integer :began_on
      t.integer :finished_on
      t.string :status, default: 'Started'
      t.integer :wages

      t.timestamps null: false
    end
    add_index :projects, [:event_id, :status]
    add_index :projects, :leader_id

    create_table :project_resources do |t|
      t.integer :project_id
      t.integer :trade_good_id
      t.integer :quantity, default: 0

      t.timestamps null: false
    end
    add_index :project_resources, [:project_id, :trade_good_id]

    create_table :project_skill_points do |t|
      t.integer :project_id
      t.integer :skill_id
      t.integer :points, default: 0

      t.timestamps null: false
    end
    add_index :project_skill_points, [:project_id, :skill_id]

    create_table :project_members do |t|
      t.integer :project_id
      t.integer :citizen_id
      t.integer :joined_on
      t.boolean :sabotaging
      
      t.timestamps null: false
    end
    add_index :project_members, [:project_id, :citizen_id]
  end
end
