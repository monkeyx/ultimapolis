class EventSkillCost < ActiveRecord::Base
# t.integer :event_id
# t.integer :skill_id
# t.integer :cost

	belongs_to :event
	belongs_to :skill
	validates :cost, numericality: {only_integer: true}
end
