class CreateCitizenTradeGoods < ActiveRecord::Migration
  def change
    create_table :citizen_trade_goods do |t|
      t.integer :citizen_id
      t.integer :trade_good_id
      t.integer :quantity

      t.timestamps null: false
    end
    add_index :citizen_trade_goods, [:citizen_id, :trade_good_id]
  end
end
