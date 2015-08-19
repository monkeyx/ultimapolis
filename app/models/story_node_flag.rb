class StoryNodeFlag < ActiveRecord::Base

	belongs_to :story_node 
	belongs_to :user

	scope :for_node, ->(node) { where(story_node_id: node.id )}
	scope :for_user, ->(user) { where(user_id: user.id )}

	after_create :add_flagged_count!
	after_destroy :remove_flagged_count!

	def add_flagged_count!
		self.story_node.flagged += 1
		self.story_node.save!
	end

	def remove_flagged_count!
		self.story_node.flagged -= 1
		self.story_node.save!
	end
end
