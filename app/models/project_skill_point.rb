class ProjectSkillPoint < ActiveRecord::Base
# t.integer :project_id
# t.integer :skill_id
# t.integer :points

	belongs_to :project
	belongs_to :skill
	validates :points, numericality: {only_integer: true}

	

end
