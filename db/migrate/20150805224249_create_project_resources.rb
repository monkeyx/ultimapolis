class CreateProjectResources < ActiveRecord::Migration
  def change
    create_table :project_resources do |t|
      t.integer :project_id
      t.integer :trade_good_id
      t.integer :quantity

      t.timestamps null: false
    end
    add_index :project_resources, [:project_id, :trade_good_id]
  end
end
