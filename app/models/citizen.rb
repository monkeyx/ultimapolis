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
	has_many :bonds
	has_many :loans
	has_many :financial_transactions
	has_many :turn_reports

	after_create :set_initial_skills!
	after_create :create_free_facility!
	after_create :increment_citizen_count!
	after_save :check_careers!
	after_destroy :decrease_citizen_count!

	#
	# Report
	#

	def add_report!(summary)
		turn_reports.create!(summary: summary, turn: Global.singleton.turn)
	end

	#
	# Credits
	#

	def add_credits!(amount, reason, other_party=nil)
		return unless amount && amount != 0
		transaction do
			self.credits += amount 
			save!
			ft = financial_transactions.new(amount: amount, turn: Global.singleton.turn, reason: reason)
			ft.other_party = other_party
			ft.save!
		end
	end

	def remove_credits!(amount, reason, other_party=nil)
		add_credits!((0 - amount), reason, other_party)
	end

	#
	# Inventory
	# 

	def trade_good_mapping(trade_good)
		return unless trade_good
		CitizenTradeGood.for_citizen(self).for_trade_good(trade_good).first
	end

	def equipment_mapping(equipment_type)
		return unless equipment_type
		CitizenEquipment.for_citizen(self).for_type(equipment_type).first
	end

	def trade_good_count(trade_good)
		ctg = trade_good_mapping(trade_good)
		ctg ? ctg.quantity : 0
	end

	def equipment_count(equipment_type)
		ce = equipment_mapping(equipment_type)
		ce ? ce.quantity : 0
	end

	def has_trade_good?(trade_good, quantity=1)
		return false unless trade_good && quantity > 0
		trade_good_count(trade_good) >= quantity
	end

	def has_equipment?(equipment_type, quantity=1)
		return false unless equipment_type && quantity > 0
		equipment_count(equipment_type) >= quantity
	end

	def equipment_for_skill(skill)
		return [] unless skill
		CitizenEquipment.for_citizen(self).in_types(EquipmentType.for_skill(skill))
	end

	def add_trade_good!(trade_good, quantity)
		return unless trade_good && quantity
		mapping = trade_good_mapping(trade_good)
		new_quantity = if mapping
			mapping.quantity += quantity
			mapping.save!
			mapping.quantity
		elsif quantity > 0
			mapping = citizen_trade_goods.create!(trade_good: trade_good, quantity: quantity)
			mapping.quantity
		else
			quantity = 0
		end
		if quantity > 0
			add_report!("Gained #{quantity} x #{trade_good}")
		elsif quantity < 0
			add_report!("Lost #{quantity.abs} x #{trade_good}")
		end
		new_quantity
	end

	def remove_trade_good!(trade_good, quantity)
		add_trade_good!(trade_good, (0 - quantity))
	end

	def add_equipment!(equipment_type, quantity=1)
		return unless equipment_type && quantity
		mapping = equipment_mapping(equipment_type)
		new_quantity = if mapping
			mapping.quantity += quantity
			mapping.save!
			mapping.quantity
		elsif quantity > 0
			mapping = citizen_equipment.create!(equipment_type: equipment_type, quantity: quantity)
			mapping.quantity
		else
			quantity = 0
		end
		if quantity > 0
			add_report!("Gained #{quantity} x #{equipment_type}")
		elsif quantity < 0
			add_report!("Lost #{quantity.abs} x #{equipment_type}")
		end
		new_quantity
	end

	def remove_equipment!(equipment_type, quantity=1)
		add_equipment!(equipment_type, (0 - quantity))
	end

	#
	# Finances
	#

	def maximum_loan
		net_worth - self.credits
	end

	def net_worth
		@net_worth ||= (self.credits + 
			citizen_equipment.to_a.sum{|e| e.value} +
			citizen_trade_goods.to_a.sum{|tg| tg.value } +
			facilities.to_a.sum{|f| f.value } + 
			bonds.to_a.sum{|b| b.total_value}) -
			loans.to_a.sum{|l| l.total_value }
	end

	#
	# Facilities
	#

	def max_trade_good_produced(trade_good)
		return 0 unless trade_good
		return -1 if trade_good.trade_good_raw_materials.empty?
		max = nil
		trade_good.trade_good_raw_materials.each do |raw_material|
			quantity = trade_good_count(raw_material.raw_material)
			max ||= quantity
			max = quantity if max > quantity
		end
		max || 0
	end

	def max_equipment_produced(equipment_type)
		return 0 unless equipment_type
		return -1 if equipment_type.equipment_raw_materials.empty?
		max = nil
		equipment_type.equipment_raw_materials.each do |raw_material|
			quantity = trade_good_count(raw_material.trade_good)
			max ||= quantity
			max = quantity if max > quantity
		end
		max || 0
	end

	def can_produce_trade_good?(trade_good, quantity=1)
		return false unless trade_good && quantity
		max_trade_good_produced(trade_good) >= quantity
	end

	def can_produce_equipment?(equipment_type, quantity=1)
		return false unless equipment_type && quantity
		max_equipment_produced(equipment_type) >= quantity
	end

	def owns_facility?(facility)
		facility && facility.citizen_id == self.id
	end

	#
	# Projects
	#

	def on_a_project?
		@on_a_project ||= ProjectMember.for_citizen(self).count > 0
	end

	def start_project!(event, wages, skip_resource_costs=false)
		self.projects.create!(event: event, wages: wages, skip_resource_costs: skip_resource_costs)
	end

	def dealing_with_event?(event)
		Project.for_event(event).for_citizen(self).count > 0
	end

	def project_member_mapping(project)
		return unless project
		ProjectMember.for_citizen(self).for_project(project).first
	end

	#
	# Careers
	#

	def current_career_mapping
		@current_career_mapping ||= CitizenCareer.for_citizen(self).current.first
	end

	#
	# Skills
	#

	def known_skills
		@known_skills ||= (self.citizen_skills.map{|cs| cs.skill } + self.citizen_equipment.map{|ce| ce.equipment_type.skill }).uniq.sort{|a,b| a.name <=> b.name }
	end

	def skill_mapping(skill)
		return unless skill 
		CitizenSkill.for_citizen(self).for_skill(skill).first
	end

	def skill_rank(skill)
		mapping = skill_mapping(skill)
		skill_rank = mapping ? mapping.rank : 0
		skill_rank += equipment_for_skill(skill).to_a.sum{|e| e.quantity * e.equipment_type.skill_modifier }
		skill_rank
	end

	def add_skill!(skill,ranks=1)
		return skill_rank(skill) unless skill && ranks > 0
		mapping = skill_mapping(skill)
		rank = if mapping
			mapping.rank += ranks
			mapping.save!
			mapping.rank
		else
			self.citizen_skills.create!(skill: skill, rank: ranks)
			ranks
		end
		add_report!("Gained #{skill} rank #{rank}")
		rank
	end

	#
	# Text
	#

	def to_s
		"Citizen \##{id}"
	end

	def status
		"Employed as #{current_profession.name} (Rank: #{self.profession_rank})" if current_profession
	end

	def facts
		return @facts if defined?(@facts)
		@facts = []
		@facts << ["Home District", home_district.name] if home_district
		@facts
	end

	#
	# Lifecycle
	#

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
			update_attributes!(profession_rank: 1)
		end
	end

	def increment_citizen_count!
		Global.singleton.update_attributes!(citizens: Global.singleton.citizens + 1)
	end

	def decrease_citizen_count!
		Global.singleton.update_attributes!(citizens: Global.singleton.citizens - 1)
	end
end
