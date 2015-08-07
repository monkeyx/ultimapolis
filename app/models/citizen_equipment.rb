class CitizenEquipment < ActiveRecord::Base
	
	belongs_to :citizen
	belongs_to :equipment_type
	validates :quantity, numericality: {only_integer: true}

	default_scope ->{ includes(:equipment_type).order('equipment_types.name ASC') }
end
