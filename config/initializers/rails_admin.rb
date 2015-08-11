RailsAdmin.config do |config|
  config.main_app_name = ["Ultimapolis", "City Core Government"]

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with :cancan

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

  config.included_models = ['Bond', 'Citizen', 'CitizenCareer', 'CitizenEquipment','CitizenSkill','CitizenTradeGood',
      'District', 'DistrictEffect', 'EquipmentRawMaterial','EquipmentType','Event','EventResourceCost','EventReward',
      'EventSkillCost','Facility','FacilityType','Global','GlobalEffect','HelpTopic','Loan','Profession',
      'Project','ProjectMember','ProjectResource','ProjectSkillPoint','Skill','TradeGood','TradeGoodRawMaterial',
      'User']

  config.model 'Bond' do 
    visible false
    object_label_method :to_s
    list do 
      field :citizen do
        sort_reverse false
      end
      field :value
      field :began_on
      field :matures_on
      sort_by :citizen
    end
  end

  config.model 'Citizen' do
    object_label_method :to_s
    navigation_icon 'icon-user'
    list do 
      field :id do
        sort_reverse false
      end
      field :home_district
      field :current_profession
      field :user
      sort_by :id
    end
    show do
      group :background do 
        field :home_district
      end
      group :profession do 
        field :current_profession
        field :profession_rank
      end
      group :user_settings do
        field :user
        field :email_notifications
        field :daily_updates
        field :instant_updates
      end
      group :profile do 
        field :citizen_careers
        field :citizen_skills
      end
      group :inventory do
        field :citizen_equipment
        field :citizen_trade_goods
      end
      group :ownership do
        field :facilities
      end
      group :finances do
        field :credits
        field :bonds 
        field :loans
      end
    end
    edit do 
      group :background do 
        field :home_district
      end
      group :profession do 
        field :current_profession
        field :profession_rank
      end
      group :user_settings do
        field :user
        field :email_notifications
        field :daily_updates
        field :instant_updates
      end
      group :profile do 
        field :citizen_careers
        field :citizen_skills
      end
      group :inventory do
        field :citizen_equipment
        field :citizen_trade_goods
      end
      group :ownership do
        field :facilities
      end
      group :finances do
        field :credits
        field :bonds 
        field :loans
      end
    end
  end

  config.model 'CitizenCareer' do 
    visible false
    object_label_method :to_s
    list do 
      field :profession
      field :career_index do
        sort_reverse false
      end
      sort_by :career_index
    end
  end

  config.model 'CitizenEquipment' do
    visible false
    object_label_method :to_s
    list do 
      field :equipment_type do
        sort_reverse false
      end
      field :quantity
      sort_by :equipment_type
    end
  end

  config.model 'CitizenSkill' do
    visible false
    object_label_method :to_s
    list do 
      field :skill do
        sort_reverse false
      end 
      field :rank
      sort_by :skill
    end
  end

  config.model 'CitizenTradeGood' do
    visible false
    object_label_method :to_s
    list do 
      field :trade_good do
        sort_reverse false
      end
      field :quantity
      sort_by :trade_good
    end
  end

  config.model 'District' do
    object_label_method :to_s
    navigation_icon 'icon-th-large'
    list do 
      field :name do
        sort_reverse false
      end
      sort_by :name
    end
    show do
      group :basic do
        field :name 
        field :description
        field :skill
      end
      group :land do
        field :total_land
        field :free_land
      end
      group :population do 
        field :civilians 
        field :automatons
      end
      group :infrastructure do
        field :housing
        field :transport_capacity
      end
      group :ratings do
        field :unrest
        field :health 
        field :policing
        field :social
        field :environment
        field :community
        field :aesthetics
        field :crime
        field :corruption
      end
      group :effects do
        field :district_effects
      end
    end
    edit do
      group :basic do
        field :name 
        field :description
        field :skill
      end
      group :land do
        field :total_land
        field :free_land
      end
      group :population do 
        field :civilians 
        field :automatons
      end
      group :infrastructure do
        field :housing
        field :transport_capacity
      end
      group :ratings do
        field :unrest
        field :health 
        field :policing
        field :social
        field :environment
        field :community
        field :aesthetics
        field :crime
        field :corruption
      end
      group :effects do
        field :district_effects
      end
    end
  end

  config.model 'DistrictEffect' do
    visible false
    object_label_method :to_s
    list do 
      field :name do
        sort_reverse false
      end
      field :district
      field :summary
      field :active
      sort_by :name
    end
    show do
      group :basic do
        field :name 
        field :active
      end
      group :land do
        field :total_land
      end
      group :population do 
        field :civilians 
        field :automatons
      end
      group :infrastructure do
        field :housing
        field :transport_capacity
      end
      group :ratings do
        field :unrest
        field :health 
        field :policing
        field :social
        field :environment
        field :community
        field :aesthetics
        field :crime
        field :corruption
      end
    end
    edit do
      group :basic do
        field :name 
        field :active
      end
      group :land do
        field :total_land
      end
      group :population do 
        field :civilians 
        field :automatons
      end
      group :infrastructure do
        field :housing
        field :transport_capacity
      end
      group :ratings do
        field :unrest
        field :health 
        field :policing
        field :social
        field :environment
        field :community
        field :aesthetics
        field :crime
        field :corruption
      end
    end
  end

  config.model 'EquipmentRawMaterial' do
    visible false
    object_label_method :to_s
    list do 
      field :trade_good do
        sort_reverse false
      end
      field :quantity
      sort_by :trade_good
    end
  end

  config.model 'EquipmentType' do
    object_label_method :to_s
    navigation_icon 'icon-briefcase'

    list do 
      field :name do
        sort_reverse false
      end
      field :skill
      field :skill_modifier
      sort_by :name
    end
    show do 
      group :basic do 
        field :name 
        field :description
      end
      group :skill do 
        field :skill
        field :skill_modifier
      end
      group :exchange do 
        field :exchange_price
      end
      group :raw_materials do 
        field :equipment_raw_materials
      end
    end
    edit do 
      group :basic do 
        field :name 
        field :description
      end
      group :skill do 
        field :skill
        field :skill_modifier
      end
      group :exchange do 
        field :exchange_price
      end
      group :raw_materials do 
        field :equipment_raw_materials
      end
    end
  end

  config.model 'Event' do 
    object_label_method :to_s
    navigation_icon 'icon-calendar'
    list do 
      field :id
      field :name
      field :event_type
      field :started_on
      field :current
      field :success
      sort_by :started_on
    end
    show do 
      group :basic do 
        field :name
        field :event_type
        field :description
        field :winning_project
      end
      group :timing do 
        field :trigger_after_event
        field :started_on
        field :finished_on
        field :max_duration
        field :current
      end
      group :costs do 
        field :event_resource_costs
        field :event_skill_costs
      end
      group :effects do 
        field :district_effects
        field :global_effects
      end
      group :reward do 
        field :event_rewards
      end
    end
    edit do 
      group :basic do 
        field :name
        field :event_type
        field :description
        field :winning_project
      end
      group :timing do 
        field :trigger_after_event
        field :started_on
        field :finished_on
        field :max_duration
        field :current
      end
      group :costs do 
        field :event_resource_costs
        field :event_skill_costs
      end
      group :effects do 
        field :district_effects
        field :global_effects
      end
      group :reward do 
        field :event_rewards
      end
    end
  end

  config.model 'EventResourceCost' do 
    visible false
    object_label_method :to_s
    list do 
      field :trade_good do
        sort_reverse false
      end
      field :quantity
      sort_by :trade_good
    end
  end

  config.model 'EventReward' do 
    visible false
    object_label_method :to_s
    list do 
      field :trade_good
      field :equipment_type do
        sort_reverse false
      end
      field :facility_type
      field :credits
      field :quantity
      sort_by :equipment_type
    end
  end

  config.model 'EventSkillCost' do 
    visible false
    object_label_method :to_s
    list do 
      field :skill do
        sort_reverse false
      end
      field :cost
      sort_by :skill
    end
  end

  config.model 'Facility' do 
    parent Citizen
    object_label_method :to_s
    navigation_icon 'icon-tower'
    list do 
      field :citizen  do
        sort_reverse false
      end
      field :facility_type
      field :level
      sort_by :citizen
    end
    show do
      group :function do 
        field :facility_type
        field :level
        field :powered
        field :maintained
      end
      group :ownership do 
        field :citizen
      end
      group :production do 
        field :producing_trade_good
        field :producing_equipment_type
      end
    end
    edit do
      group :function do 
        field :facility_type
        field :level
        field :powered
        field :maintained
      end
      group :ownership do 
        field :citizen
      end
      group :production do 
        field :producing_trade_good
        field :producing_equipment_type
      end
    end
  end

  config.model 'FacilityType' do 
    object_label_method :to_s
    navigation_icon 'icon-tower'
    list do 
      field :name do
        sort_reverse false
      end
      field :district
      field :build_cost
      field :maintenance_cost
      sort_by :name
    end
    show do 
      group :basic do 
        field :name
        field :description
      end
      group :costs do 
        field :build_cost 
        field :maintenance_cost
      end
      group :workers do 
        field :employees
        field :automation
      end
      group :power do 
        field :power_generation
        field :power_consumption
        field :pollution
      end
      group :housing do 
        field :housing_mod
      end
      group :production do 
        field :equipment_types
        field :trade_goods
      end
    end
    edit do 
      group :basic do 
        field :name
        field :description
      end
      group :costs do 
        field :build_cost 
        field :maintenance_cost
      end
      group :workers do 
        field :employees
        field :automation
      end
      group :power do 
        field :power_generation
        field :power_consumption
        field :pollution
      end
      group :housing do 
        field :housing_mod
      end
      group :production do 
        field :equipment_types
        field :trade_goods
      end
    end
  end

  config.model 'Global' do 
    object_label_method :to_s
    navigation_icon 'icon-time'
    list do 
      field :id
      sort_by :id
    end
    show do 
      group :turns do 
        field :turn
      end
      group :economy do
        field :citizens
        field :gdp
        field :grid
        field :inflation
        field :interest
        field :power
      end
      group :ratings do 
        field :borders
        field :climate
        field :infrastructure
        field :liberty
        field :security
        field :stability
      end
    end
    edit do 
      group :turns do 
        field :turn
      end
      group :economy do
        field :citizens
        field :gdp
        field :grid
        field :inflation
        field :interest
        field :power
      end
      group :ratings do 
        field :borders
        field :climate
        field :infrastructure
        field :liberty
        field :security
        field :stability
      end
    end
  end

  config.model 'GlobalEffect' do 
    parent Global
    object_label_method :to_s
    navigation_icon 'icon-cog'
    list do 
      field :name do
        sort_reverse false
      end
      field :summary
      field :active
      sort_by :name
    end
    show do 
      field :active
      group :economy do
        field :grid
        field :inflation
        field :power
      end
      group :ratings do 
        field :borders
        field :climate
        field :infrastructure
        field :liberty
        field :security
        field :stability
      end
    end
    edit do 
      field :active
      group :economy do
        field :grid
        field :inflation
        field :power
      end
      group :ratings do 
        field :borders
        field :climate
        field :infrastructure
        field :liberty
        field :security
        field :stability
      end
    end
  end

  config.model 'HelpTopic' do 
    object_label_method :to_s
    navigation_icon 'icon-question-sign'
    list do 
      field :name
      field :topic_index do
        sort_reverse false
      end
      sort_by :topic_index
    end
  end

  config.model 'Loan' do 
    visible false
    object_label_method :to_s
    list do 
      field :citizen do
        sort_reverse false
      end
      field :value
      field :began_on
      field :matures_on
      sort_by :citizen
    end
  end

  config.model 'Profession' do 
    object_label_method :to_s
    navigation_icon 'icon-knight'
    list do 
      field :name do
        sort_reverse false
      end
      field :profession_group
      sort_by :name
    end
    show do 
      group :basic do 
        field :name
        field :profession_group
        field :description
      end
      group :skill do 
        field :primary_skills
        field :secondary_skills
        field :tertiary_skills
      end
    end
    edit do 
      group :basic do 
        field :name
        field :profession_group
        field :description
      end
      group :skill do 
        field :primary_skills
        field :secondary_skills
        field :tertiary_skills
      end
    end
  end

  config.model 'Project' do 
    parent Event
    object_label_method :to_s
    navigation_icon 'icon-blackboard'
    list do 
      field :event do
        sort_reverse false
      end
      field :leader
      field :status
      field :began_on
      sort_by :event
    end
    show do 
      group :basic do 
        field :leader
        field :event
        field :status
        field :wages
      end
      group :timing do 
        field :began_on
        field :finished_on
      end
      group :members do
        field :project_members
      end
      group :progress do 
        field :project_resources
        field :project_skill_points
      end
    end
    edit do 
      group :basic do 
        field :leader
        field :event
        field :status
        field :wages
      end
      group :timing do 
        field :began_on
        field :finished_on
      end
      group :members do
        field :project_members
      end
      group :progress do 
        field :project_resources
        field :project_skill_points
      end
    end
  end

  config.model 'ProjectMember' do 
    visible false
    object_label_method :to_s
    list do 
      field :citizen do
        sort_reverse false
      end
      field :project
      sort_by :citizen
    end
  end

  config.model 'ProjectResource' do 
    visible false
    object_label_method :to_s
    list do 
      field :trade_good do
        sort_reverse false
      end
      field :quantity
      sort_by :trade_good
    end
  end

  config.model 'ProjectSkillPoint' do 
    visible false
    object_label_method :to_s
    list do 
      field :skill  do
        sort_reverse false
      end
      field :points
      sort_by :skill
    end
  end

  config.model 'Skill' do 
    object_label_method :to_s
    navigation_icon 'icon-flash'
    list do 
      field :name do
        sort_reverse false
      end
      field :skill_group
      sort_by :name
    end
    show do 
      group :basic do 
        field :name
        field :skill_group
        field :description
      end
      group :professions do 
        field :primary_profession
        field :secondary_profession
        field :tertiary_profession
      end
    end
    edit do 
      group :basic do 
        field :name
        field :skill_group
        field :description
      end
      group :professions do 
        field :primary_profession
        field :secondary_profession
        field :tertiary_profession
      end
    end
  end

  config.model 'TradeGood' do 
    object_label_method :to_s
    navigation_icon 'icon-gift'
    list do 
      field :name do
        sort_reverse false
      end
      field :facility_type
      sort_by :name
    end
    show do 
      group :basic do 
        field :name
        field :description
      end
      group :production do 
        field :facility_type
      end
      group :exchange do 
        field :exchange_price
      end
      group :raw_materials do 
        field :trade_good_raw_materials
      end
    end
    edit do 
      group :basic do 
        field :name
        field :description
      end
      group :production do 
        field :facility_type
      end
      group :exchange do 
        field :exchange_price
      end
      group :raw_materials do 
        field :trade_good_raw_materials
      end
    end
  end

  config.model 'TradeGoodRawMaterial' do 
    visible false
    object_label_method :to_s
    list do 
      field :raw_material do
        sort_reverse false
      end
      field :quantity
      sort_by :raw_material
    end
  end

  config.model 'User' do 
    object_label_method :username
    navigation_icon 'icon-user'
    list do 
      field :id
      field :email
      sort_by :id
    end
    show do 
      group :account do 
        field :email
        field :role
      end
      group :locking do 
        field :locked_at
      end
      group :password do 
        field :password
        field :password_confirmation
      end
    end
    edit do 
      group :account do 
        field :email
        field :role
      end
      group :locking do 
        field :locked_at
      end
      group :password do 
        field :password
        field :password_confirmation
      end
    end
  end
end
