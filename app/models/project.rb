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

    validate :validate_project

	has_many :project_members
	has_many :project_resources
	has_many :project_skill_points

	before_save :set_began_on
	after_create :add_leader_as_member!
	after_create :add_resources!
	before_save :wage_change_membership_adjustment!
	after_destroy :return_resources!
	after_create :add_create_report!
	after_destroy :add_cancel_report!

	scope :for_citizen, ->(citizen) { where(["leader_id = ? OR id IN (?)",citizen.id, [0] + ProjectMember.for_citizen(citizen).map{|pm| pm.project_id}]) }	
	scope :for_event, ->(event) { where(event_id: event.id ) }
	scope :not_for_citizen, ->(citizen) { where(["leader_id <> ? AND id NOT IN (?)",citizen.id, [0] + ProjectMember.for_citizen(citizen).map{|pm| pm.project_id}]) }	
	
	default_scope ->{ order('began_on ASC') }

	attr_accessor :skip_resource_costs

	def status_enum
		PROJECT_STATUS
	end

	def has_member?(citizen)
		project_members.where(citizen_id: citizen.id).count > 0
	end

	def project_status?(project_status)
    	self.status == project_status
    end

    def event_resource_costs
    	@event_resource_costs ||= self.event && self.event.event_resource_costs
    end

    def event_skill_costs
    	@event_skill_costs ||= self.event && self.event.event_skill_costs
    end

    def event_rewards
    	@event_rewards ||= self.event && self.event.event_rewards
    end

    def resource_mapping(trade_good)
    	return unless trade_good
    	ProjectResource.for_project(self).for_trade_good(trade_good).first
    end

    def skill_mapping(skill)
    	return unless skill
    	ProjectSkillPoint.for_project(self).for_skill(skill).first
    end

    def resource_count(trade_good)
    	mapping = resource_mapping(trade_good)
    	mapping ? mapping.quantity : 0
    end

    def skill_points(skill)
    	mapping = skill_mapping(skill)
    	mapping ? mapping.points : 0
    end

    def has_resources?
    	return true unless event_resource_costs
    	event_resource_costs.each do |resource_cost|
    		return false unless resource_count(resource_cost.trade_good) >= resource_cost.cost
    	end
    	true
    end

    def has_skill_points?
    	return true unless event_skill_costs
    	event_skill_costs.each do |skill_cost|
    		return false unless skill_points(skill_cost.skill) >= skill_cost.cost
    	end
    	true
    end

    def completable?
    	has_resources? && has_skill_points?
    end

    def add_resource!(trade_good, quantity, free_cost=false)
    	return unless trade_good && quantity && self.leader.trade_good_count(trade_good) >= quantity
    	transaction do
    		mapping = resource_mapping(trade_good)
    		if mapping 
    			mapping.quantity += quantity
    			mapping.save!
    		else
    			project_resources.create!(trade_good: trade_good, quantity: quantity)
    		end
    		self.leader.remove_trade_good!(trade_good, quantity) unless free_cost
    	end
    end

    def add_skills!
    	transaction do
	    	event_skill_costs.each do |skill_cost|
	    		skill_mapping = skill_mapping(skill_cost.skill)
	    		skill_mapping ||= project_skill_points.create!(skill: skill_cost.skill, points: 0)
	    		if skill_cost.cost >= skill_mapping.points # work to be done in this skill
			    	project_members.each do |member|
			    		if (skill_rank = member.citizen.skill_rank(skill_cost.skill)) > 0 # member can contribute
			    			if self.leader.credits >= (skill_rank * self.wages) # leader can afford to pay
			    				# pay wages
			    				member_wages = (skill_rank * self.wages)
			    				self.leader.remove_credits!(member_wages, "Pay Wages for #{self}", member.citizen)
			    				member.citizen.add_credits!(member_wages, "Wages for #{self}", self.leader)
			    				# contribute
			    				skill_mapping.points += skill_rank
			    			end
			    		end
			    	end
			    	skill_mapping.save!
			    end
		    end
		end
    end

    def complete!
    	return unless completable?
    	transaction do
	    	self.status = 'Finished'
	    	event_rewards.each do |event_reward|
	    		if event_reward.trade_good && event_reward.quantity > 0
	    			self.leader.add_trade_good!(event_reward.trade_good, event_reward.quantity)
	    		end
	    		if event_reward.equipment_type && event_reward.quantity > 0
	    			self.leader.add_equipment!(event_reward.equipment_type, event_reward.quantity)
	    		end
	    		if event_reward.facility_type && event_reward.quantity > 0
	    			event_reward.quantity.times do
	    				Facility.create_new!(self.leader, event_reward.facility_type, true)
	    			end
	    		end
	    		if event_reward.credits && event_reward.quantity > 0
	    			self.leader.add_credits!(event_reward.quantity, "Winning #{self}")
	    		end
	    	end
	    	self.leader.save!
	    	project_members.each do |member|
				member.citizen.add_report!("Project #{self} was completed")
			end
	    	self.event.resolve!(self)
	    end
    end

	def to_s
		return unless event
		if event.crisis?
			"Crisis: #{event}"
		elsif event.opportunity?
			"Opportunity: #{event}"
		end
	end

	def validate_project
		if new_record?
			unless self.leader 
				errors.add(:leader, "not set")
				return
			end
			if self.leader.on_a_project?
				errors.add(:leader, "already on a project")
				return
			end
			unless skip_resource_costs
				has_resources = true
		    	event_resource_costs.each do |resource_cost|
		    		unless self.leader.trade_good_count(resource_cost.trade_good) >= resource_cost.cost
		    			has_resources = false 
		    			break
		    		end
		    	end
		    	unless has_resources
		    		errors.add(:leader, "doesn't have resources to start project")
		    	end
		    end
		end
	end

	def set_began_on
		self.began_on ||= Global.singleton.turn
	end

	def add_leader_as_member!
		project_members.create!(citizen: leader)
	end

	def wage_change_membership_adjustment!
		if wages_changed?
			self.leader.add_report!("Changed wages on #{self} to #{wages}")
		end
		if wages_changed? && wages_was && wages < wages_was
			project_members.each do |member|
				unless member.citizen_id == leader.id
					member.citizen.add_report!("Project #{self} lowered wages")
					member.destroy
				end
			end
		end
	end

	def add_resources!
		unless skip_resource_costs
			event_resource_costs.each do |resource_cost|
				add_resource!(resource_cost.trade_good, resource_cost.cost)
	    	end
	    else
	    	event_resource_costs.each do |resource_cost|
				add_resource!(resource_cost.trade_good, resource_cost.cost, true)
	    	end
	    end
	end

	def return_resources!
		unless finished?
			transaction do
				project_resources.each do |resource|
					self.leader.add_trade_good!(resource.trade_good, resource.quantity)
				end
			end
		end
	end

	def add_create_report!
		self.leader.add_report!("Started project #{self}")
	end

	def add_cancel_report!
		project_members.each do |member|
			member.citizen.add_report!("Project #{self} was cancelled")
		end
	end

	def turn_update!
		unless finished?
			add_skills!
			complete!
		end
	end
end
