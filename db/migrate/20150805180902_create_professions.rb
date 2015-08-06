class CreateProfessions < ActiveRecord::Migration
  def change
    create_table :professions do |t|
      t.string :name
      t.string :profession_group
      t.text :description
      t.string :icon

      t.timestamps null: false
    end

    add_index :professions, [:name, :profession_group]
  end
end
