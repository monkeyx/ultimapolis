class StoryChoice < ActiveRecord::Base

	CHOICE_TYPES = ['Choice','Challenge','Threat']
	SKILL_GROUPS = [''] + Skill::SKILL_GROUPS

	belongs_to :story_node
	validates :choice_type, inclusion: {in: CHOICE_TYPES }
	belongs_to :success_node, class_name: 'StoryNode'
	belongs_to :failure_node, class_name: 'StoryNode'
	validates :description, length: {in: 3..64 }
	validates :skill_group, inclusion: {in: SKILL_GROUPS }

    validate :validate_choice

	CHOICE_TYPES.each do |choice_type|
    	define_method("#{choice_type.downcase}?") do
  			choice_type?(choice_type)
	  	end
	  	scope "#{choice_type.downcase.pluralize}".to_sym, -> { where(choice_type: choice_type)}
    end

    def type_and_skill
        unless choice?
            "[#{choice_type} using #{skill_group}] "
        end
    end

    def name
        "#{description}"
    end

    def story
    	return unless self.story_node
    	self.story_node.story 
    end

    def success?(citizen)
        return false unless citizen
    	if choice?
    		true
    	elsif !self.skill_group.blank?
    		rank = citizen.best_skill_rank_in_group(self.skill_group)
    		difficulty = 5 + citizen.story_difficulty(story)
    		return rand(12) + rank > difficulty
    	end
    	false
    end

    def show_skill_group?
    	!choice?
    end

    def choice_type?(choice_type)
    	self.choice_type == choice_type
    end

	def choice_type_enum
		CHOICE_TYPES
	end

	def skill_group_enum
		SKILL_GROUPS
	end

    def validate_choice
        unless choice?
            if skill_group.blank?
                errors.add(:skill_group, "must be chosen for challenging and threatening choices")
            end
        end
    end
end
