class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    can :read, [Citizen, District, DistrictEffect, EquipmentType, FacilityType, GlobalEffect, Petition, Profession, Skill, TradeGood]
    
    can :read, Event, current: true

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
            can :vote_for, Petition
            can :vote_against, Petition
            can :create, [Facility, Petition, Project, ProjectMember, ExchangeEquipment, ExchangeTradeGood]

            can :update, Facility, citizen_id: user.citizen.id
            can :update, Project, leader_id: user.citizen.id
            can :update, Petition, citizen_id: user.citizen.id, accepted: false

            can :destroy, Facility, citizen_id: user.citizen.id
            can :destroy, Project, leader_id: user.citizen.id
            can :destroy, Petition, citizen_id: user.citizen.id, accepted: false

            can :destroy, ProjectMember, citizen_id: user.citizen.id 

            can :read, FinancialTransaction, citizen_id: user.citizen.id
            can :read, TurnReport, citizen_id: user.citizen.id
            can :read, TurnReport, citizen_id: nil
        end
    end

  end
end
