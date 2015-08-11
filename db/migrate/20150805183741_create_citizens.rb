class CreateCitizens < ActiveRecord::Migration
  def change
    create_table :citizens do |t|
      t.boolean :email_notifications, default: true
      t.boolean :daily_updates, default: false
      t.boolean :instant_updates, default: true
      t.bigint :credits, default: 0
      t.integer :home_district_id
      t.integer :current_profession_id
      t.integer :profession_rank, default: 0
      t.integer :current_project_id
      t.string :icon
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :citizens, :user_id
    add_index :citizens, :current_project_id
    add_index :citizens, :home_district_id

    create_table :citizen_skills do |t|
      t.integer :citizen_id
      t.integer :skill_id
      t.integer :rank, default: 0

      t.timestamps null: false
    end
    add_index :citizen_skills, [:citizen_id, :skill_id]

    create_table :citizen_trade_goods do |t|
      t.integer :citizen_id
      t.integer :trade_good_id
      t.integer :quantity, default: 0

      t.timestamps null: false
    end
    add_index :citizen_trade_goods, [:citizen_id, :trade_good_id]

    create_table :citizen_equipments do |t|
      t.integer :citizen_id
      t.integer :equipment_type_id
      t.integer :quantity, default: 0

      t.timestamps null: false
    end
    add_index :citizen_equipments, [:citizen_id, :equipment_type_id]

    create_table :citizen_careers do |t|
      t.integer :citizen_id
      t.integer :profession_id
      t.integer :career_index, default: 0
      t.integer :term_length, default: 0
      t.boolean :current, default: true

      t.timestamps null: false
    end
    add_index :citizen_careers, [:citizen_id, :profession_id, :career_index], name: 'idx_career_mapping'
    add_index :citizen_careers, [:citizen_id, :current]
  end
end
