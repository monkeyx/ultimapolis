class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :leader_id
      t.integer :event_id
      t.integer :began_on
      t.integer :finished_on
      t.string :status
      t.integer :wages

      t.timestamps null: false
    end
    add_index :projects, [:event_id, :status]
    add_index :projects, :leader_id
  end
end
