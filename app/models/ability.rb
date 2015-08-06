class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    if user.admin?
        can :access, :rails_admin
        can :dashboard
        can :manage, :all
    elsif user.player?
        can :create, [Citizen, Facility, Project]
        can :update, Citizen, user_id: user.id
        can :destroy, Citizen, user_id: user.id
        
        if user.citizen
            can :update, Facility, citizen_id: user.citizen.id
            can :update, Project, leader_id: user.citizen.id

            can :destroy, Facility, citizen_id: user.citizen.id
            can :destroy, Project, leader_id: user.citizen.id
        end
    end

    can :read, [Citizen, District, DistrictEffect, EquipmentType, Event, Facility, GlobalEffect, Project, Skill, TradeGood]
    
  end
end
