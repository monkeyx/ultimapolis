class GlobalEffect < ActiveRecord::Base
# t.integer :event_id
# t.integer :started_on
# t.integer :expires_on
# t.boolean :active
# t.string :name
# t.text :description
# t.string :icon
# t.integer :infrastructure_mod
# t.integer :grid_mod
# t.integer :power_mod
# t.integer :stability_mod
# t.integer :climate_mod
# t.integer :liberty_mod
# t.integer :security_mod
# t.integer :borders_mod
# t.integer :inflation_mod

	belongs_to :event
	validates :infrastructure_mod, numericality: {only_integer: true}
	validates :grid_mod, numericality: {only_integer: true}
	validates :power_mod, numericality: {only_integer: true}
	validates :stability_mod, numericality: {only_integer: true}
	validates :climate_mod, numericality: {only_integer: true}
	validates :liberty_mod, numericality: {only_integer: true}
	validates :security_mod, numericality: {only_integer: true}
	validates :borders_mod, numericality: {only_integer: true}
	validates :inflation_mod, numericality: {only_integer: true}
end
