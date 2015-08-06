class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :name
      t.integer :skill_id
      t.integer :total_land
      t.integer :free_land
      t.integer :transport_capacity
      t.integer :civilians
      t.integer :automatons
      t.integer :unrest
      t.integer :health
      t.integer :policing
      t.integer :social
      t.integer :environment
      t.integer :housing
      t.integer :education
      t.integer :community
      t.integer :creativity
      t.integer :aesthetics
      t.integer :crime
      t.integer :corruption
      t.text :description
      t.string :icon

      t.timestamps null: false
    end
  end
end
