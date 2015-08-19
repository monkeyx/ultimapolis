class StoryNode < ActiveRecord::Base

	ICONS = ['','adjust',' align-center',' align-justify',' align-left',' align-right',' arrow-down',' arrow-left',' arrow-right',' arrow-up',' asterisk',' backward',' ban-circle',' barcode',' bell',' bold',' book',' bookmark',' briefcase',' bullhorn',' calendar',' camera',' certificate',' check',' chevron-down',' chevron-left',' chevron-right',' chevron-up',' circle-arrow-down',' circle-arrow-left',' circle-arrow-right',' circle-arrow-up',' cog',' comment',' download',' download-alt',' edit',' eject',' envelope',' exclamation-sign',' eye-close',' eye-open',' facetime-video',' fast-backward',' fast-forward',' file',' film',' filter',' fire',' flag',' folder-close',' folder-open',' font',' forward',' fullscreen',' gift',' glass',' globe',' hand-down',' hand-left',' hand-right',' hand-up',' hdd',' headphones',' heart',' home',' inbox',' indent-left',' indent-right',' info-sign',' italic',' leaf',' list',' list-alt',' lock',' magnet',' map-marker',' minus',' minus-sign',' move',' music',' off',' ok',' ok-circle',' ok-sign',' pause',' pencil',' picture',' plane',' play',' play-circle',' plus',' plus-sign',' print',' qrcode',' question-sign',' random',' refresh',' remove',' remove-circle',' remove-sign',' repeat',' resize-full',' resize-horizontal',' resize-small',' resize-vertical',' retweet',' road',' screenshot',' search',' share',' share-alt',' shopping-cart',' signal',' star',' star-empty',' step-backward',' step-forward',' stop',' tag',' tags',' tasks',' text-height',' text-width',' th',' th-large',' th-list',' thumbs-down',' thumbs-up',' time',' tint',' trash',' upload',' user',' volume-down',' volume-off',' volume-up',' warning-sign',' wrench',' zoom-in',' zoom-out']

	belongs_to :story
	validates :name, presence: true
	validates :name, length: {in: 5..128 }
	validates :narrative, length: {minimum: 3 }, if: :active?
	validates :icon_css, inclusion: {in: ICONS }
	belongs_to :created_by, class_name: 'User'
	# t.boolean :active, default: false
	validates :flagged, numericality: {only_integer: true}

	has_many :story_choices, dependent: :delete_all
	has_many :citizen_stories, dependent: :delete_all
	has_many :story_node_flags, dependent: :delete_all

	after_create :post_creation!

	attr_accessor :story_choice_id, :choice_result

	scope :order_flagged, -> { order("flagged DESC")}

	def flagged?(user)
		StoryNodeFlag.for_node(self).for_user(user).first
	end

	def flag!(user)
		story_node_flags.create!(user: user)
	end

	def unflag!(user)
		f = flagged?(user)
		f.destroy if f
	end

	def first?
		self.story && self.story.first_node_id == self.id 
	end

	def icon_css_enum
		ICONS
	end

	def new_choice
		StoryChoice.new(story_node: self, choice_type: 'Choice')
	end

	def new_challenge
		StoryChoice.new(story_node: self, choice_type: 'Challenge')
	end

	def new_threat
		StoryChoice.new(story_node: self, choice_type: 'Threat')
	end

	def post_creation!
		if story && !story.active 
			story.update_attributes!(active: true, first_node: self)
		end
		unless self.story_choice_id.blank?
			choice = StoryChoice.find(self.story_choice_id)
			if choice_result
				choice.success_node = self
			else
				choice.failure_node = self
			end
			choice.save!
		end
	end
end
