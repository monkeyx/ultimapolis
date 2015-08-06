class CreateProjectMembers < ActiveRecord::Migration
  def change
    create_table :project_members do |t|
      t.integer :project_id
      t.integer :citizen_id
      t.integer :joined_on
      t.integer :left_on
      t.boolean :active
      t.integer :contribution
      t.integer :wages

      t.timestamps null: false
    end
    add_index :project_members, [:project_id, :citizen_id, :active]
  end
end
