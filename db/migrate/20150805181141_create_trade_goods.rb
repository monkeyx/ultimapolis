class CreateTradeGoods < ActiveRecord::Migration
  def change
    create_table :trade_goods do |t|
      t.string :name
      t.integer :facility_type_id
      t.integer :exchange_price
      t.integer :total
      t.integer :produced_last_turn
      t.integer :for_sale
      t.text :description
      t.string :icon

      t.timestamps null: false
    end
    add_index :trade_goods, :facility_type_id
  end
end
