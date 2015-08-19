class Story < ActiveRecord::Base

	belongs_to :first_node, class_name: 'StoryNode'
	belongs_to :created_by, class_name: 'User'
	validates :name, presence: true
	validates :name, length: {in: 5..128 }
	# t.boolean :active, default: false

	has_many :story_nodes, dependent: :delete_all
	has_many :citizen_stories, dependent: :delete_all

	scope :active, -> { where(active: true )}

	default_scope ->{ includes(:first_node).order('stories.name ASC') }

	def create_first_node!(narrative, created_by, icon_css='')
		return unless narrative && created_by
		StoryNode.create!(story: self, name: "Prologue", narrative: narrative, icon_css: icon_css, created_by: created_by)
	end
end
