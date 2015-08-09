class Project < ActiveRecord::Base

	PROJECT_STATUS = %w(Started Finished)

	belongs_to :leader, class_name: 'Citizen'
	belongs_to :event 
	validates :status, inclusion: {in: PROJECT_STATUS}
	validates :wages, numericality: {only_integer: true}
	# t.integer :began_on
	# t.integer :finished_on

	PROJECT_STATUS.each do |project_status|
    	define_method("#{project_status.downcase}?") do
  			project_status?(project_status)
	  	end
	  	scope "#{project_status.downcase}".to_sym, -> { where(status: project_status)}
    end

	has_many :project_members
	has_many :project_resources
	has_many :project_skill_points

	before_save :set_began_on
	after_create :add_leader_as_member!
	before_save :wage_change_membership_adjustment!

	scope :for_citizen, ->(citizen) { where(["leader_id = ? OR id IN (?)",citizen.id, ProjectMember.for_citizen(citizen).map{|pm| pm.project_id}]) }	
	scope :for_event, ->(event) { where(event_id: event.id ) }
	scope :not_for_citizen, ->(citizen) { where(["leader_id <> ? AND id NOT IN (?)",citizen.id, ProjectMember.for_citizen(citizen).map{|pm| pm.project_id}]) }	
	
	default_scope ->{ order('began_on ASC') }

	def has_member?(citizen)
		project_members.where(citizen_id: citizen.id).count > 0
	end

	def project_status?(project_status)
    	self.status == project_status
    end

	def to_s
		return unless event
		if event.crisis?
			"Crisis Project: #{event}"
		elsif event.opportunity?
			"Opportunity: #{event}"
		end
	end

	def set_began_on
		self.began_on ||= Global.singleton.turn
	end

	def add_leader_as_member!
		project_members.create!(citizen: leader, active: true)
	end

	def wage_change_membership_adjustment!
		if wages_changed? && wages_was && wages < wages_was
			project_members.each do |member|
				unless member.citizen_id == leader.id
					member.destroy
				end
			end
		end
	end

	def turn_update!
		# TODO
	end
end
