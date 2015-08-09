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
  end
end
