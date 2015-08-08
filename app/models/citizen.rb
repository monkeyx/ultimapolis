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

	after_create :set_initial_skills!
	after_create :create_free_facility!
	after_create :increment_citizen_count!
	after_save :check_careers!
	after_destroy :decrease_citizen_count!

	def dealing_with_event?(event)
		Project.for_event(event).for_citizen(self).count > 0
	end

	def owns_facility?(facility)
		facility && facility.citizen_id == self.id
	end

	def project_member_mapping(project)
		return unless project
		ProjectMember.for_citizen(self).for_project(project).first
	end

	def current_career_mapping
		@current_career_mapping ||= CitizenCareer.for_citizen(self).current.first
	end

	def skill_mapping(skill)
		return unless skill 
		CitizenSkill.for_citizen(self).for_skill(skill).first
	end

	def skill_rank(skill)
		mapping = skill_mapping(skill)
		mapping ? mapping.rank : 0
	end

	def add_skill!(skill,ranks=1)
		return skill_rank(skill) unless skill && ranks > 0
		mapping = skill_mapping(skill)
		if mapping
			mapping.rank += ranks
			mapping.save!
			return mapping.rank
		else
			self.citizen_skills.create!(skill: skill, rank: ranks)
			return ranks
		end
	end

	def to_s
		"Citizen \##{id}"
	end

	def status
		"Employed as a #{current_profession.name}" if current_profession
	end

	def facts
		return @facts if defined?(@facts)
		@facts = []
		@facts << ["Home District", home_district.name] if home_district
		@facts
	end

	def set_initial_skills!
		add_skill!(home_district.skill) if home_district && home_district.skill
		if current_profession
			current_profession.skills.each do |skill|
				add_skill!(skill)
			end
		end
	end

	def create_free_facility!
		if home_district && home_district.free_facility_for_new_citizen?
			facility_type = FacilityType.for_district(home_district).build_cost_less_or_equal_to(1000).to_a.sample
			Facility.create_new!(self, facility_type, true)
		end
	end

	def check_careers!
		if current_career_mapping.nil? || (current_career_mapping.profession_id != current_profession_id)
			if current_career_mapping
				current_career_mapping.update_attributes!(current: false)
			end
			career_index = CitizenCareer.for_citizen(self).count + 1
			citizen_careers.create!(profession: current_profession, career_index: career_index, current: true)
		end
	end

	def increment_citizen_count!
		Global.singleton.update_attributes!(citizens: Global.singleton.citizens + 1)
	end

	def decrease_citizen_count!
		Global.singleton.update_attributes!(citizens: Global.singleton.citizens - 1)
	end
end
