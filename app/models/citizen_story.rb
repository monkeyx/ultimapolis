class CitizenStory < ActiveRecord::Base

	belongs_to :citizen 
	belongs_to :story 
	belongs_to :story_node
	# t.boolean :finished, default: false
	validates :challenges, numericality: {only_integer: true}
	validates :threats, numericality: {only_integer: true}

	scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
	scope :for_story, ->(story) { where(story_id: story.id )}
	scope :not_finished, -> { where(finished: false )}
	scope :finished, -> { where(finished: true )}

	def self.start_story!(citizen, story, restart=false)
		return unless citizen && story && story.active
		if restart
			status = CitizenStory.for_citizen(citizen).for_story(story).first
			status.destroy if status
		end
		CitizenStory.create!(citizen: citizen, story: story, story_node: story.first_node)
		citizen.add_report!(story.first_node.narrative)
	end

	def self.restartable_story?(citizen, story)
		status = CitizenStory.for_citizen(citizen).for_story(story).first
		status && restartable_in_hours(citizen, story) < 1
	end

	def self.restartable_in_hours(citizen, story)
		status = CitizenStory.for_citizen(citizen).for_story(story).first
		unless status
			0
		else
			(((status.updated_at + 6.hours) - Time.now) / 3600.0).round(0).to_i
		end
	end

	def self.current_story_status(citizen, story)
		CitizenStory.for_citizen(citizen).for_story(story).not_finished.first
	end

	def self.current_node(citizen, story)
		return unless citizen && story && story.active
		cs = CitizenStory.current_story_status(citizen, story)
		cs ? cs.story_node || story.first_node : nil
	end

	def self.next_node!(citizen, node)
		return unless citizen && node && node.story && node.story.active
		cs = CitizenStory.current_story_status(citizen, node.story)
		if cs 
			cs.story_node = node
			cs.save!
			citizen.add_report!(node.narrative) unless node.narrative.blank?
		end
	end

	def self.overcame_challenge!(citizen, story)
		cs = CitizenStory.current_story_status(citizen, story)
		if cs 
			cs.challenges += 1
			cs.save!
			reward!(citizen, story, citizen.story_difficulty(story), "meeting challenge")
		end
	end

	def self.overcame_threat!(citizen, story)
		cs = CitizenStory.current_story_status(citizen, story)
		if cs 
			cs.threats += 1
			cs.save!
			reward!(citizen, story, citizen.story_difficulty(story) * 5, "overcoming threat")
		end
	end

	def self.reward!(citizen, story, difficulty, description)
		amount = difficulty * difficulty * 10
		citizen.add_credits!(amount, "Gained #{amount} credits for #{description} in #{story.name}")
		"Gained #{amount} credits"
	end

	def self.finish_story!(citizen, story)
		return unless citizen && story && story.active
		cs = CitizenStory.current_story_status(citizen, story)
		if cs 
			cs.finished = true
			cs.save!
		end
	end
end
