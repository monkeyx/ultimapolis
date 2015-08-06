class Profession < ActiveRecord::Base
# t.string :name
# t.string :group
# t.text :description
# t.string :icon

	validates :name, presence: true
	has_many :primary_skills, class_name: 'Skill', foreign_key: 'primary_profession_id'
	has_many :secondary_skills, class_name: 'Skill', foreign_key: 'secondary_profession_id'
	has_many :tertiary_skills, class_name: 'Skill', foreign_key: 'tertiary_profession_id'

	

end
