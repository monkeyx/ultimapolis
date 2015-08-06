class Project < ActiveRecord::Base
# t.integer :leader_id
# t.integer :event_id
# t.integer :began_on
# t.integer :finished_on
# t.string :status
# t.integer :wages

	PROJECT_STATUS = %w(init started cancelled finished)

	belongs_to :leader, class_name: 'Citizen'
	belongs_to :event 
	validates :status, inclusion: {in: PROJECT_STATUS}
	validates :wages, numericality: {only_integer: true}

	has_many :project_members
	has_many :project_resources
	has_many :project_skill_points

	

end
