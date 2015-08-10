class ProjectMember < ActiveRecord::Base

	belongs_to :project
	belongs_to :citizen
	# t.integer :joined_on
	# t.integer :left_on
	# t.boolean :active
	validates :contribution, numericality: {only_integer: true}
	validates :wages, numericality: {only_integer: true}

	before_create :set_joined_on
	after_create :add_join_report!
	after_destroy :add_leave_report!

	scope :for_project, ->(project) { where(project_id: project.id )}	
	scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
	scope :active, -> { where(active: true )}

	def set_joined_on
		joined_on = Global.singleton.turn
	end

	def add_join_report!
		unless self.citizen_id == self.project.leader_id
			self.citizen.add_report!("Joined Project #{self.project}") 
			self.project.leader.add_report!("#{self.citizen} joined Project #{self.project}")
		end
	end

	def add_leave_report!
		unless self.citizen_id == self.project.leader_id
			self.citizen.add_report!("Left Project #{self.project}") 
			self.project.leader.add_report!("#{self.citizen} left Project #{self.project}")
		end
	end
end
