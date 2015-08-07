class GlobalEffect < ActiveRecord::Base

	belongs_to :event
	# t.integer :started_on
	# t.integer :expires_on
	# t.boolean :active
	validates :name, presence: true
	# t.text :description
	# t.string :icon
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
