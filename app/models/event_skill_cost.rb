class EventSkillCost < ActiveRecord::Base

	belongs_to :event
	belongs_to :skill
	validates :cost, numericality: {only_integer: true}

	def to_s
		"#{skill} #{cost}"
	end
end
