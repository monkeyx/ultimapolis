class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    can :read, [Citizen, District, DistrictEffect, EquipmentType, Event, FacilityType, GlobalEffect, Profession, Skill, TradeGood]
    
    if user.admin? || user.citizen.nil?
        can :create, Citizen
    end

    if user.admin?
        can :access, :rails_admin
        can :dashboard
        can :manage, :all
    elsif user.player?
        can :update, Citizen, user_id: user.id
        can :destroy, Citizen, user_id: user.id
        
        if user.citizen
            can :read, [Facility, Project]
            can :create, [Facility, Project, ProjectMember]

            can :update, Facility, citizen_id: user.citizen.id
            can :update, Project, leader_id: user.citizen.id

            can :destroy, Facility, citizen_id: user.citizen.id
            can :destroy, Project, leader_id: user.citizen.id

            can :destroy, ProjectMember, citizen_id: user.citizen.id 
        end
    end

  end
end
