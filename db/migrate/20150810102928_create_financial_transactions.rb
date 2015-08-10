class CreateFinancialTransactions < ActiveRecord::Migration
  def change
    create_table :financial_transactions do |t|
      t.integer :citizen_id
      t.integer :turn
      t.integer :amount
      t.string :reason
      t.integer :other_party_id
      t.string :other_party_class

      t.timestamps null: false
    end

    add_index :financial_transactions, [:citizen_id, :turn]
  end
end
