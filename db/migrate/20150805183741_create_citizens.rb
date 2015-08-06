class CreateCitizens < ActiveRecord::Migration
  def change
    create_table :citizens do |t|
      t.boolean :email_notifications
      t.boolean :daily_updates
      t.boolean :instant_updates
      t.integer :credits
      t.integer :home_district_id
      t.integer :current_profession_id
      t.integer :profession_rank
      t.integer :current_project_id
      t.string :icon
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :citizens, :user_id
    add_index :citizens, :current_project_id
    add_index :citizens, :home_district_id
  end
end
