class CitizenSkill < ActiveRecord::Base

	belongs_to :citizen
	belongs_to :skill
	validates :rank, numericality: {only_integer: true}

	scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
	scope :for_skill, ->(skill) { where(skill_id: skill.id )}
	scope :for_skill_group, ->(skill_group) { where(["skill_id IN (?)", [0] + Skill.for_group(skill_group).map{|s| s.id } ])}
	scope :order_rank, -> { order("rank DESC")}

	default_scope ->{ includes(:skill).order('skills.name ASC') }

	def to_s
		"#{skill} #{rank}"
	end
end
