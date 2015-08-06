class CreateProjectSkillPoints < ActiveRecord::Migration
  def change
    create_table :project_skill_points do |t|
      t.integer :project_id
      t.integer :skill_id
      t.integer :points

      t.timestamps null: false
    end
    add_index :project_skill_points, [:project_id, :skill_id]
  end
end
