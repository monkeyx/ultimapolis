class CreateCitizenCareers < ActiveRecord::Migration
  def change
    create_table :citizen_careers do |t|
      t.integer :citizen_id
      t.integer :profession_id
      t.integer :career_index
      t.integer :term_length
      t.boolean :current

      t.timestamps null: false
    end
    add_index :citizen_careers, [:citizen_id, :profession_id, :career_index], name: 'career_mapping'
    add_index :citizen_careers, [:citizen_id, :current]
  end
end
