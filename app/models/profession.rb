class Profession < ActiveRecord::Base

	PROFESSION_GROUPS = %w(Agent Military Corporate Entertainer Merchant Government Rogue Scientist)

	validates :name, presence: true
	validates :profession_group, inclusion: {in: PROFESSION_GROUPS}
	# t.text :description
	# t.string :icon
	has_many :primary_skills, class_name: 'Skill', foreign_key: 'primary_profession_id'
	has_many :secondary_skills, class_name: 'Skill', foreign_key: 'secondary_profession_id'
	has_many :tertiary_skills, class_name: 'Skill', foreign_key: 'tertiary_profession_id'

	default_scope ->{ order('name ASC') }

	acts_as_commontable

	def self.create_new!(name, group, description)
		create!(
			name: name,
			profession_group: group,
			description: description,
			icon: "/icons/professions/#{name.gsub(' ', '_').downcase}.png",
		)
	end

	def profession_group_enum
		PROFESSION_GROUPS
	end

	def to_s
		name
	end

	def skills
		@skills ||= (primary_skills.to_a + secondary_skills.to_a + tertiary_skills.to_a).sort{|a, b| a.name <=> b.name }
	end

end
