module NavigationHelper
	def navigation_items
  		@navigation_items ||= [
        ['Stories', main_app.stories_path, nil],
  			['Districts', main_app.districts_path, nil],
        ['Petitions', '/petitions', nil],
        ['Databank',nil,
          [
            ['Equipment', main_app.equipment_types_path],
            ['Facilities', main_app.facility_types_path],
            ['Professions', main_app.professions_path],
            ['Skills', main_app.skills_path],
            ['Trade Goods', main_app.trade_goods_path],
            ['',''],
            ['Charts', '/charts']
          ]
        ]
  		]
  	end

  	def is_navigation_active?(name)
  		name && controller_name.camelcase == name.gsub(' ','')
  	end
end