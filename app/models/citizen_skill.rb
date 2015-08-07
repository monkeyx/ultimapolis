class CitizenSkill < ActiveRecord::Base

	belongs_to :citizen
	belongs_to :skill
	validates :rank, numericality: {only_integer: true}

	scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
	scope :for_skill, ->(skill) { where(skill_id: skill.id )}

	default_scope ->{ includes(:skill).order('skills.name ASC') }
end
