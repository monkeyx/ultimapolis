class ProjectMember < ActiveRecord::Base

	belongs_to :project
	belongs_to :citizen
	# t.integer :joined_on
	# t.integer :left_on
	# t.boolean :active
	validates :contribution, numericality: {only_integer: true}
	validates :wages, numericality: {only_integer: true}

	scope :for_project, ->(project) { where(project_id: project.id )}	
	scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
	scope :active, -> { where(active: true )}
end
