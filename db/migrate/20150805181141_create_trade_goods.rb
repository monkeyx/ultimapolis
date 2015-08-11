class CreateTradeGoods < ActiveRecord::Migration
  def change
    create_table :trade_goods do |t|
      t.string :name
      t.integer :facility_type_id
      t.integer :exchange_price, default: 0
      t.text :description
      t.string :icon

      t.timestamps null: false
    end
    add_index :trade_goods, :facility_type_id

    create_table :trade_good_raw_materials do |t|
      t.integer :trade_good_id
      t.integer :raw_material_id
      t.integer :quantity, default: 0

      t.timestamps null: false
    end
    add_index :trade_good_raw_materials, [:trade_good_id, :raw_material_id], name: 'idx_tgrm_mapping'

  end
end
