class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :first_node_id
      t.integer :created_by_id
      t.string :name
      t.boolean :active, default: false

      t.timestamps null: false
    end

    add_index :stories, [:created_by_id, :active]

    create_table :story_nodes do |t|
      t.integer :story_id
      t.string :name
      t.text :narrative
      t.string :icon_css, default: ''
      t.integer :created_by_id
      t.boolean :active, default: false
      t.integer :flagged, default: 0

      t.timestamps null: false
    end

    add_index :story_nodes, :story_id
    add_index :story_nodes, :created_by_id

    create_table :story_choices do |t|
      t.integer :story_node_id
      t.text :description
      t.string :choice_type, default: 'Choice'
      t.integer :success_node_id
      t.integer :failure_node_id
      t.string :skill_group, default: ''

      t.timestamps null: false
    end

    add_index :story_choices, :story_node_id
    add_index :story_choices, :success_node_id
    add_index :story_choices, :failure_node_id

    create_table :citizen_stories do |t|
      t.integer :citizen_id
      t.integer :story_id
      t.boolean :finished, default: false
      t.integer :story_node_id
      t.integer :challenges, default: 0
      t.integer :threats, default: 0

      t.timestamps null: false
    end

    add_index :citizen_stories, [:citizen_id, :story_id, :finished], name: 'idx_citizen_stories'

    create_table :story_node_flags do |t|
      t.integer :story_node_id
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :story_node_flags, [:story_node_id, :user_id], name: 'idx_node_flags'
  end
end
