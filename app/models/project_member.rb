class ProjectMember < ActiveRecord::Base
# t.integer :project_id
# t.integer :citizen_id
# t.integer :joined_on
# t.integer :left_on
# t.boolean :active
# t.integer :contribution
# t.integer :wages

	belongs_to :project
	belongs_to :citizen
	validates :contribution, numericality: {only_integer: true}
	validates :wages, numericality: {only_integer: true}

	

end
