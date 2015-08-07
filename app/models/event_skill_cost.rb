class EventSkillCost < ActiveRecord::Base

	belongs_to :event
	belongs_to :skill
	validates :cost, numericality: {only_integer: true}
end
