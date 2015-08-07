class Facility < ActiveRecord::Base

	belongs_to :citizen
	belongs_to :facility_type
	# t.boolean :powered
	# t.boolean :maintained
	validates :level, numericality: {only_integer: true}
	belongs_to :producing_trade_good, class_name: 'TradeGood'
    belongs_to :producing_equipment_type, class_name: 'EquipmentType'

    scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
    scope :for_facility_type, ->(facility_type) { where(facility_type_id: facility_type.id )}

    default_scope ->{ includes(:facility_type).order('facility_types.name ASC') }
	
    def self.create_new!(citizen, facility_type)
    	create!(
    		citizen: citizen,
    		facility_type: facility_type,
    		powered: true,
    		maintained: true,
    		level: 1
    	)
    end
end
