class User < ActiveRecord::Base
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :omniauthable

    USER_ROLES = %w(player admin)

    validates :role, inclusion: {in:  USER_ROLES}

    has_one :citizen
    has_many :stories, dependent: :nullify, foreign_key: 'created_by_id'
    has_many :story_nodes, dependent: :nullify, foreign_key: 'created_by_id'
    
    acts_as_commontator
    acts_as_voter

    USER_ROLES.each do |role|
    	define_method("#{role}?") do
  			role?(role)
	  	end
	  	scope "#{role.pluralize}".to_sym, -> { where(role: role)}
    end

    scope :not_admin, -> { where(["role <> ?", 'admin'])}

    after_create :send_registration!

    def send_registration!
      UserMailer.registered(self).deliver unless !Rails.env.production? || admin?
    end
    handle_asynchronously :send_registration!

    def send_turn_report!(turn)
      UserMailer.turn_report(self,turn).deliver unless !Rails.env.production? || admin? || self.citizen.nil?
    end
    handle_asynchronously :send_turn_report!

    def citizen_path
      self.citizen ? "/citizens/#{self.citizen.id}" : nil
    end

    def role_enum
      USER_ROLES
    end

    def role?(role)
    	self.role == role
    end

    def username
      if player?
        if citizen
          citizen.to_s
        else
          'Ghost Avatar'
        end
      elsif admin?
        'City Core'
      else
        'Anonymous'
      end
    end
end
