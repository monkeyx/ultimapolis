class District < ActiveRecord::Base
# t.string :name
# t.integer :skill_id
# t.integer :total_land
# t.integer :free_land
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
# t.text :description
# t.string :icon

	validates :name, presence: true
	belongs_to :skill 
	validates :total_land, numericality: {only_integer: true}
	validates :free_land, numericality: {only_integer: true}
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

	has_many :district_effects
	has_many :facility_types

	

end
