class ProjectResource < ActiveRecord::Base
# t.integer :project_id
# t.integer :trade_good_id
# t.integer :quantity

	belongs_to :project
	belongs_to :trade_good
	validates :quantity, numericality: {only_integer: true}

	

end
