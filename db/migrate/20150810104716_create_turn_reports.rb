class CreateTurnReports < ActiveRecord::Migration
  def change
    create_table :turn_reports do |t|
      t.integer :turn
      t.integer :citizen_id
      t.integer :district_id
      t.text :summary

      t.timestamps null: false
    end
    add_index :turn_reports, :turn
    add_index :turn_reports, [:turn, :citizen_id]
    add_index :turn_reports, [:turn, :district_id]
  end
end
