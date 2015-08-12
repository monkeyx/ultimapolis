class DistrictSnapshot < ActiveRecord::Base
	belongs_to :district 
	validates :turn, numericality: {only_integer: true}
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

	scope :for_district, ->(district) { where(district_id: district.id) }
end
