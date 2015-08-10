class ProjectSkillPoint < ActiveRecord::Base

	belongs_to :project
	belongs_to :skill
	validates :points, numericality: {only_integer: true}

	scope :for_project, ->(project) { where(project_id: project.id )}	
	scope :for_skill, ->(skill) { where(skill_id: skill.id )}
end
