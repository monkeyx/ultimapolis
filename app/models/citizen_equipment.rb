class CitizenEquipment < ActiveRecord::Base
	
	belongs_to :citizen
	belongs_to :equipment_type
	validates :quantity, numericality: {only_integer: true}

	scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
	scope :for_type, ->(equipment_type) { where(equipment_type_id: equipment_type.id )}
	scope :in_types, ->(equipment_types) { where(["equipment_type_id in (?)", equipment_types.map{|et| et.id }])}

	default_scope ->{ includes(:equipment_type).order('equipment_types.name ASC') }

	def value
		return 0 unless self.equipment_type
		@value ||= (self.quantity * self.equipment_type.exchange_price)
	end
end
