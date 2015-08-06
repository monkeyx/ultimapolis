class Citizen < ActiveRecord::Base

	validates :credits, numericality: {only_integer: true}
	belongs_to :home_district, class_name: 'District'
	validates :home_district_id, presence: true
	belongs_to :current_profession, class_name: 'Profession'
	validates :current_profession_id, presence: true
	validates :profession_rank, numericality: {only_integer: true}
	belongs_to :user
	# t.boolean :email_notifications
	# t.boolean :daily_updates
	# t.boolean :instant_updates
	# t.integer :credits
	# t.string :icon

	has_many :citizen_careers
	has_many :citizen_equipment
	has_many :citizen_skills
	has_many :citizen_trade_goods
	has_many :facilities
	has_many :projects, foreign_key: 'leader_id'
	has_many :project_members

	after_create :set_initial_skills
	after_save :check_careers

	def to_s
		"Citizen \##{id}"
	end

	def status
		"Employed as #{current_profession.name}" if current_profession
	end

	def facts
		return @facts if defined?(@facts)
		@facts = []
		@facts << ["Home District", home_district.name] if home_district
		@facts
	end

	def set_initial_skills
		# todo set initial skills
	end

	def check_careers
		# Todo if profession changed add new citizen career
	end
end
