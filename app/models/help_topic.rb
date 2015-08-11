class HelpTopic < ActiveRecord::Base
	
	validates :name, presence: true
	validates :topic_index, numericality: {only_integer: true }
	validates :topic_index, uniqueness: true
	validates :summary, presence: true
	validates :body, presence: true

	default_scope ->{ order('topic_index ASC') }

	acts_as_commontable

	def to_s
		name
	end
end
