class CreateCitizenSkills < ActiveRecord::Migration
  def change
    create_table :citizen_skills do |t|
      t.integer :citizen_id
      t.integer :skill_id
      t.integer :rank

      t.timestamps null: false
    end
    add_index :citizen_skills, [:citizen_id, :skill_id]
  end
end
