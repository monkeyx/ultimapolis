module EventTypes
	require 'csv'
	extend ActiveSupport::Concern

	def self.template_file_path
		File.expand_path('../../../../config/event_templates.csv', __FILE__)
	end

	def self.crisis_templates
		@@crisis_templates ||= event_templates && event_templates.select{|template| template['Type'] == 'Crisis'}
	end

	def self.opportunity_templates
		@@opportunity_templates ||= event_templates && event_templates.select{|template| template['Type'] == 'Opportunity'}
	end

	def self.generate_crisis!
		triggered = false
		sanity = 10
		while !triggered && sanity > 0 do
			district = District.all.to_a.sample
			crisis_templates.each do |template|
				if event_triggable?(template, district)
					triggered = true
					create_event!(district, template)
					break
				end
			end
			sanity -= 1
		end
		raise "Could not generate crisis" unless triggered
	end

	def self.generate_opportunity!
		district = District.all.to_a.sample
		create_event!(district, opportunity_templates.sample)
	end

	def self.event_templates
		return unless File.exist?(template_file_path)
		@@event_templates ||= CSV.read(template_file_path, headers: true)
	end

	def self.event_triggable?(template, district)
		return false unless district
		return true if template['Trigger'].blank?
		district.send(template['Trigger'].to_sym)
	end

	def self.create_event!(district, template)
		event = Event.create!(
			name: "#{district}: #{template['Name']}",
			event_type: template['Type'],
			started_on: Global.singleton.turn,
			max_duration: 24,
			summary: template['Summary'],
			description: template['Description'],
			icon: "/icons/#{template['Type'].downcase}/#{template['Name'].gsub(' ', '_').downcase}.png"
		)
		
		unless template['District Effect +'].blank?
			effect_field = template['District Effect +'].strip.to_sym
			event.add_district_effect!(district, effect_field, 5)
		end
		unless template['District Effect -'].blank?
			effect_field = template['District Effect -'].strip.to_sym
			event.add_district_effect!(district, effect_field, -5)
		end
		unless template['Global Effect +'].blank?
			effect_field = template['Global Effect +'].strip.to_sym
			event.add_global_effect!(effect_field, 5)
		end
		unless template['Global Effect -'].blank?
			effect_field = template['Global Effect -'].strip.to_sym
			event.add_global_effect!(effect_field, -5)
		end

		unless template['Resource x 3'].blank?
			trade_good = TradeGood.where(name: template['Resource x 3'].strip).first
			if trade_good
				event.add_resource_cost!(trade_good, 3 * EventTypes.random_multiplier)
			end
		end
		unless template['Resource x 2'].blank?
			trade_good = TradeGood.where(name: template['Resource x 2'].strip).first
			if trade_good
				event.add_resource_cost!(trade_good, 2 * EventTypes.random_multiplier)
			end
		end
		unless template['Resource x 1'].blank?
			trade_good = TradeGood.where(name: template['Resource x 1'].strip).first
			if trade_good
				event.add_resource_cost!(trade_good, EventTypes.random_multiplier)
			end
		end

		unless template['Skills x 3'].blank?
			skill = Skill.where(name: template['Skills x 3'].strip).first
			if skill
				event.add_skill_cost!(skill, 3 * EventTypes.random_multiplier)
			end
		end
		unless template['Skills x 2'].blank?
			skill = Skill.where(name: template['Skills x 2'].strip).first
			if skill
				event.add_skill_cost!(skill, 2 * EventTypes.random_multiplier)
			end
		end
		unless template['Skills x 1'].blank?
			skill = Skill.where(name: template['Skills x 1'].strip).first
			if skill
				event.add_skill_cost!(skill, EventTypes.random_multiplier)
			end
		end

		unless template['Rewards'].blank?
			equipment_type = EquipmentType.where(name: template['Rewards'].strip).first
			unless equipment_type
				trade_good = TradeGood.where(name: template['Rewards'].strip).first
				if trade_good
					event.add_trade_goods_reward!(trade_good, EventTypes.random_multiplier)
				end
			else
				event.add_equipment_reward!(equipment_type)
			end
		end

		event.add_credit_reward!(template['Reward Credits'].to_i * EventTypes.random_multiplier) unless template['Reward Credits'].blank?
	end

	def self.random_multiplier
		1 + rand(Global.singleton.citizens)
	end
end