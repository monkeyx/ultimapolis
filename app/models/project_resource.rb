class ProjectResource < ActiveRecord::Base

	belongs_to :project
	belongs_to :trade_good
	validates :quantity, numericality: {only_integer: true}

	scope :for_project, ->(project) { where(project_id: project.id )}	
	scope :for_trade_good, ->(trade_good) { where(trade_good_id: trade_good.id )}

	def to_s
		"#{trade_good} x #{quantity}"
	end
end
