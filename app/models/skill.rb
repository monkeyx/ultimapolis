class Skill < ActiveRecord::Base
# t.string :name
# t.string :group
# t.text :description
# t.string :icon
# t.integer :primary_profession_id
# t.integer :secondary_profession_id
# t.integer :tertiary_profession_id

	validates :name, presence: true
	belongs_to :primary_profession, class_name: 'Profession'
	belongs_to :secondary_profession, class_name: 'Profession'
	belongs_to :tertiary_profession, class_name: 'Profession'

	

end
