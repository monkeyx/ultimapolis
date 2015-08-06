json.array!(@trade_goods) do |trade_good|
  json.extract! trade_good, :id, :name, :facility_type_id, :exchange_price, :total, :produced_last_turn, :for_sale
  json.url trade_good_url(trade_good, format: :json)
end
