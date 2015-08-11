module NavigationHelper
	def navigation_items
  		@navigation_items ||= [
  			['Districts', main_app.districts_path, nil],
        ['News', '/news', nil],
        ['Petitions', '/petitions', nil],
        ['Databank',nil,
          [
            ['Equipment', main_app.equipment_types_path],
            ['Facilities', main_app.facility_types_path],
            ['Professions', main_app.professions_path],
            ['Skills', main_app.skills_path],
            ['Trade Goods', main_app.trade_goods_path]
          ]
        ]
  		]
  	end

  	def is_navigation_active?(name)
  		name && controller_name.camelcase == name.gsub(' ','')
  	end
end