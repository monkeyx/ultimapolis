class CreateBonds < ActiveRecord::Migration
  def change
    create_table :bonds do |t|
      t.integer :citizen_id
      t.bigint :value
      t.integer :issued_on
      t.integer :matures_on
      t.integer :interest

      t.timestamps null: false
    end
    add_index :bonds, [:citizen_id, :issued_on, :matures_on], name: 'idx_bonds'
  end
end
