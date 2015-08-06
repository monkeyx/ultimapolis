class CreateProfessions < ActiveRecord::Migration
  def change
    create_table :professions do |t|
      t.string :name
      t.string :group
      t.text :description
      t.string :icon

      t.timestamps null: false
    end
  end
end
