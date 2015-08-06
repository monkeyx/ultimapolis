class DistrictEffect < ActiveRecord::Base
# t.integer :event_id
# t.integer :district_id
# t.integer :started_on
# t.integer :expires_on
# t.boolean :active
# t.string :name
# t.text :description
# t.string :icon
# t.integer :total_land
# t.integer :transport_capacity
# t.integer :civilians
# t.integer :automatons
# t.integer :unrest
# t.integer :health
# t.integer :policing
# t.integer :social
# t.integer :environment
# t.integer :housing
# t.integer :education
# t.integer :community
# t.integer :creativity
# t.integer :aesthetics
# t.integer :crime
# t.integer :corruption
	
	belongs_to :event
	belongs_to :district
	validates :total_land, numericality: {only_integer: true}
	validates :transport_capacity, numericality: {only_integer: true}
	validates :civilians, numericality: {only_integer: true}
	validates :automatons, numericality: {only_integer: true}
	validates :unrest, numericality: {only_integer: true}
	validates :health, numericality: {only_integer: true}
	validates :policing, numericality: {only_integer: true}
	validates :social, numericality: {only_integer: true}
	validates :environment, numericality: {only_integer: true}
	validates :housing, numericality: {only_integer: true}
	validates :education, numericality: {only_integer: true}
	validates :community, numericality: {only_integer: true}
	validates :creativity, numericality: {only_integer: true}
	validates :aesthetics, numericality: {only_integer: true}
	validates :crime, numericality: {only_integer: true}
	validates :corruption, numericality: {only_integer: true}
end
