module EventTypes
	extend ActiveSupport::Concern

	def self.template_file_path
		File.expand_path('../../../../config/event_templates.yml', __FILE__)
	end

	def self.crisis_templates
		@@crisis_templates ||= event_templates && event_templates.select{|template| template['event_type'] == 'Crisis'}
	end

	def self.opportunity_templates
		@@opportunity_templates ||= event_templates && event_templates.select{|template| template['event_type'] == 'Opportunity'}
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

private
	def self.event_templates
		return @@event_templates if defined?(@@event_templates)
		return unless File.exist?(template_file_path)
		file = File.open(template_file_path)
		@@event_templates = YAML.load(file.read)
		file.close
		@@event_templates
	end

	def self.event_triggable?(template, district)
		return false unless district
		return true if template['trigger'].blank?
		district.send(template['trigger'].to_sym)
	end

	def self.create_event!(district, template)
		event = Event.create!(
			name: "#{district}: #{template['name']}",
			event_type: template['event_type'],
			started_on: Global.singleton.turn,
			max_duration: template['max_duration'],
			summary: template['summary'],
			description: template['description'],
			icon: "/icons/#{template['event_type'].downcase}/#{template['name'].gsub(' ', '_').downcase}.png"
		)
		if template['district_effects'] && template['district_effects'].is_a?(Array)
			template['district_effects'].each do |district_effect_template|
				event.add_district_effect!(district_effect_template.merge(district: district))
			end
		end
		if template['global_effects'] && template['global_effects'].is_a?(Array)
			template['global_effects'].each do |global_effect_template|
				event.add_global_effect!(global_effect_template)
			end
		end
		if template['resource_costs'] && template['resource_costs'].is_a?(Array)
			template['resource_costs'].each do |resource_cost_entry|
				trade_good = TradeGood.where(name: resource_cost_entry['name']).first
				if trade_good
					event.add_resource_cost!(trade_good, resource_cost_entry['cost'].to_i * EventTypes.random_multiplier)
				end
			end
		end
		if template['skill_costs'] && template['skill_costs'].is_a?(Array)
			template['skill_costs'].each do |skill_cost_entry|
				skill = Skill.where(name: skill_cost_entry['name']).first
				if skill
					event.add_skill_cost!(skill, skill_cost_entry['cost'].to_i * EventTypes.random_multiplier)
				end
			end
		end
		if template['reward_trade_goods'] && template['reward_trade_goods'].is_a?(Array)
			template['reward_trade_goods'].each do |reward_entry|
				trade_good = TradeGood.where(name: reward_entry['name']).first
				if trade_good
					event.add_trade_goods_reward!(trade_good, reward_entry['quantity'].to_i * EventTypes.random_multiplier)
				end
			end
		end
		if template['reward_equipment'] && template['reward_equipment'].is_a?(Array)
			template['reward_equipment'].each do |reward_entry|
				equipment = EquipmentType.where(name: reward_entry).first
				if equipment
					event.add_equipment_reward!(equipment)
				end
			end
		end
		if template['reward_facility'] && template['reward_facility'].is_a?(Array)
			template['reward_facility'].each do |reward_entry|
				facility = FacilityType.where(name: reward_entry).first
				if facility
					event.add_facility_reward!(facility)
				end
			end
		end
		event.add_credit_reward!(template['reward_credts'].to_i * EventTypes.random_multiplier) unless template['reward_credts'].blank?
	end

	def self.random_multiplier
		1 + rand(Global.singleton.citizens)
	end
end