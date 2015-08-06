class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :event_type
      t.integer :started_on
      t.integer :finished_on
      t.integer :max_duration
      t.boolean :current
      t.boolean :success
      t.text :summary
      t.text :description
      t.integer :winning_project_id
      t.string :icon

      t.timestamps null: false
    end
    add_index :events, [:event_type, :current]
    add_index :events, [:started_on, :finished_on, :success]
  end
end
