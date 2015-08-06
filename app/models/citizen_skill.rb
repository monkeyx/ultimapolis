class CitizenSkill < ActiveRecord::Base
# t.integer :citizen_id
# t.integer :skill_id
# t.integer :rank
	belongs_to :citizen
	belongs_to :skill
	validates :rank, numericality: {only_integer: true}
end
