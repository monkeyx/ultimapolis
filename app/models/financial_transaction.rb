class FinancialTransaction < ActiveRecord::Base
	
	belongs_to :citizen
	validates :turn, numericality: {only_integer: true }
	validates :amount, numericality: {only_integer: true }
	validates :reason, presence: true

	scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
	scope :for_turn, ->(turn) { where(turn: turn )}
	scope :with_other, ->(other_party) { where(other_party_id: other_party.id, other_party_class: other_party.class.name )}

	default_scope ->{ order('created_at DESC') }

	def other_party=(other)
		return unless other
		self.other_party_id = other.id 
		self.other_party_class = other.class.name
	end

	def other_party
		if self.other_party_class && self.other_party_id
			Object.const_get(self.other_party_class).find(self.other_party_id)
		end
	end
end
