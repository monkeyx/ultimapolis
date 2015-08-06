class CreateGlobals < ActiveRecord::Migration
  def change
    create_table :globals do |t|
      t.integer :infrastructure
      t.integer :grid
      t.integer :power
      t.integer :stability
      t.integer :climate
      t.integer :liberty
      t.integer :security
      t.integer :borders
      t.integer :turn
      t.integer :inflation
      t.integer :citizens
      t.integer :gdp

      t.timestamps null: false
    end
  end
end
