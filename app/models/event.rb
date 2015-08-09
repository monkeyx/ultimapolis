class Event < ActiveRecord::Base
	include EventTypes

	EVENT_TYPES = %w(Crisis Opportunity)

	validates :name, presence: true
	validates :event_type, inclusion: {in: EVENT_TYPES}
	# t.integer :started_on
	# t.integer :finished_on
	validates :max_duration, numericality: {only_integer: true }
	# t.boolean :current
	# t.boolean :success
	# t.text :summary
	# t.text :description
	# t.string :icon
	belongs_to :trigger_after_event, class_name: 'Event'
	belongs_to :winning_project, class_name: 'Project'

	EVENT_TYPES.each do |event_type|
    	define_method("#{event_type.downcase}?") do
  			event_type?(event_type)
	  	end
	  	scope "#{event_type.downcase.pluralize}".to_sym, -> { where(event_type: event_type)}
    end

	has_many :district_effects
	has_many :global_effects
	has_many :event_resource_costs
	has_many :event_rewards
	has_many :event_skill_costs
	has_many :projects
	has_one :previous_event, foreign_key: 'trigger_after_event_id', class_name: 'Event'

	scope :current, -> { where(current: true )}

	def self.current_opportunity
		@@current_opportunity ||= Event.where(event_type: 'Opportunity', current: true).first
	end

	def self.current_crisis
		@@current_crisis ||= Event.where(event_type: 'Crisis', current: true).first
	end

	def event_type?(event_type)
    	self.event_type == event_type
    end
	
	def add_district_effect!(options={})
		district_effects.create!(options)
	end

	def add_global_effect!(options={})
		global_effects.create!(options)
	end

	def add_resource_cost!(trade_good, cost)
		event_resource_costs.create!(trade_good: trade_good, cost: cost)
	end

	def add_skill_cost!(skill, cost)
		event_skill_costs.create!(skill: skill, cost: cost)
	end

	def add_trade_goods_reward!(trade_good, quantity)
		event_rewards.create!(trade_good: trade_good, quantity: quantity)
	end

	def add_equipment_reward!(equipment_type)
		event_rewards.create!(equipment_type: equipment_type, quantity: 1)
	end

	def add_facility_reward!(facility_type)
		event_rewards.create!(facility_type: facility_type, quantity: 1)
	end

	def add_credit_reward!(quantity)
		event_rewards.create!(credits: true, quantity: quantity)
	end

	def suitable_projects(citizen)
		Project.for_event(self).not_for_citizen(citizen).started
	end

	def to_s
		name 
	end

	def expires
		if max_duration > 0
			started_on + max_duration
		else
			-1
		end
	end
end
