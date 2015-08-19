module StoriesHelper
	def current_story_status(story)
		if current_citizen
			current_citizen.current_story_status(story)
		end
	end

	def story_button(story)
		status = current_story_status(story)
		if status 
			if !status.finished
				link_to('Continue', status.story_node, class: 'btn-lg btn-primary')
			elsif CitizenStory.restartable_story?(current_citizen, story)
				link_to('Restart', "#{story_node_path(story.first_node)}?restart=yes", class: 'btn-lg btn-primary')
			else
				"Restartable in #{pluralize(CitizenStory.restartable_in_hours(current_citizen, story), 'hour')}"
			end
		else
			link_to('Start', story.first_node, class: 'btn-lg btn-primary')
		end
	end

	def current_story_narrative(story)
		status = current_story_status(story)
		narrative = if status 
			status.story_node.narrative
		else
			story.first_node.narrative
		end
		narrative.blank? ? 'What happened next is still to be written' : narrative
	end
end
