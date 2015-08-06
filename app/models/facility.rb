class Facility < ActiveRecord::Base
# t.integer :citizen_id
# t.integer :facility_type_id
# t.boolean :powered
# t.boolean :maintained
# t.integer :utilised
# t.integer :level

	belongs_to :citizen
	belongs_to :facility_type
	validates :utilised, numericality: {only_integer: true}
	validates :level, numericality: {only_integer: true}

	

end
