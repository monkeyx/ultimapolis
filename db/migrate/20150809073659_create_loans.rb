class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.integer :citizen_id
      t.bigint :value
      t.integer :issued_on
      t.integer :matures_on
      t.integer :interest

      t.timestamps null: false
    end
    add_index :loans, [:citizen_id, :issued_on, :matures_on], name: 'idx_loans'
  end
end
