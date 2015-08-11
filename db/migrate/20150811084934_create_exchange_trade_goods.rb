class CreateExchangeTradeGoods < ActiveRecord::Migration
  def change
    create_table :exchange_trade_goods do |t|
      t.integer :trade_good_id
      t.integer :citizen_id
      t.integer :turn
      t.integer :price
      t.integer :quantity

      t.timestamps null: false
    end
    add_index :exchange_trade_goods, [:trade_good_id, :citizen_id, :turn], name: 'idx_exchange_goods'
  end
end
