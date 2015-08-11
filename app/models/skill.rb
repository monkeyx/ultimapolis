class Skill < ActiveRecord::Base
	
	validates :name, presence: true
	validates :skill_group, presence: true
	# t.text :description
	# t.string :icon
	belongs_to :primary_profession, class_name: 'Profession'
	belongs_to :secondary_profession, class_name: 'Profession'
	belongs_to :tertiary_profession, class_name: 'Profession'
	has_one :district

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

	def to_s
		name
	end
end
