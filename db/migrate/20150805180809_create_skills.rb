class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.string :skill_group
      t.text :description
      t.string :icon
      t.integer :primary_profession_id
      t.integer :secondary_profession_id
      t.integer :tertiary_profession_id

      t.timestamps null: false
    end

    add_index :skills, [:name, :skill_group]
    add_index :skills, :primary_profession_id
    add_index :skills, :secondary_profession_id
    add_index :skills, :tertiary_profession_id
  end
end
