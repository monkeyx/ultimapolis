class Event < ActiveRecord::Base
# t.string :name
# t.string :event_type
# t.integer :started_on
# t.integer :finished_on
# t.integer :max_duration
# t.boolean :current
# t.boolean :success
# t.text :summary
# t.text :description
# t.integer :winning_project_id
# t.string :icon

	EVENT_TYPES = %(Crisis Opportunity)

	validates :name, presence: true
	validates :event_type, inclusion: {in: EVENT_TYPES}
	belongs_to :trigger_after_event, class_name: 'Event'
	belongs_to :winning_project, class_name: 'Project'

	has_many :district_effects
	has_many :global_effects
	has_many :event_resource_costs
	has_many :event_rewards
	has_many :event_skill_costs
	has_many :projects
	has_one :previous_event, foreign_key: 'trigger_after_event_id', class_name: 'Event'
	

end
