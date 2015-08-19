class Skill < ActiveRecord::Base
		
	SKILL_GROUPS = %w(Animal Art Business Intelligence Legal Military Physique Science Social Tech)

	validates :name, presence: true
	validates :name, length: {in: 3..255 }
	validates :skill_group, inclusion: {in: SKILL_GROUPS}
	# t.text :description
	# t.string :icon
	belongs_to :primary_profession, class_name: 'Profession'
	belongs_to :secondary_profession, class_name: 'Profession'
	belongs_to :tertiary_profession, class_name: 'Profession'
	has_one :district

	scope :for_group, ->(group) { where(skill_group: group)}
	
	default_scope ->{ order('name ASC') }

	acts_as_commontable

	def self.create_new!(name, group, description, primary, secondary, tertiary)
		create!(
			name: name,
			skill_group: group,
			description: description,
			icon: "/icons/skills/#{name.gsub(' ', '_').downcase}.png",
			primary_profession: primary,
			secondary_profession: secondary,
			tertiary_profession: tertiary
		)
	end

	def skill_group_enum
		SKILL_GROUPS
	end

	def to_s
		name
	end
end
