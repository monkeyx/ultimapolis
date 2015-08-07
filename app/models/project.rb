class Project < ActiveRecord::Base

	PROJECT_STATUS = %w(draft started cancelled finished)

	belongs_to :leader, class_name: 'Citizen'
	belongs_to :event 
	validates :status, inclusion: {in: PROJECT_STATUS}
	validates :wages, numericality: {only_integer: true}
	# t.integer :began_on
	# t.integer :finished_on

	has_many :project_members
	has_many :project_resources
	has_many :project_skill_points

	scope :for_citizen, ->(citizen) { where(["leader_id = ? OR id IN (?)",citizen.id, ProjectMember.for_citizen(citizen).map{|pm| pm.project.id}]) }	

	default_scope ->{ order('began_on ASC') }
end
