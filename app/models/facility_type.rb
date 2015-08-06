class FacilityType < ActiveRecord::Base
# t.string :name
# t.integer :district_id
# t.text :description
# t.string :icon
# t.integer :build_cost
# t.integer :maintenance_cost
# t.integer :employees
# t.integer :automation
# t.integer :power_consumption
# t.integer :power_generation
# t.integer :pollution
	
	validates :name, presence: true
	belongs_to :district
	validates :build_cost, numericality: {only_integer: true}
	validates :maintenance_cost, numericality: {only_integer: true}
	validates :employees, numericality: {only_integer: true}
	validates :automation, numericality: {only_integer: true}
	validates :power_consumption, numericality: {only_integer: true}
	validates :power_generation, numericality: {only_integer: true}
	validates :pollution, numericality: {only_integer: true}

	has_many :equipment_types
	has_many :trade_goods
end
