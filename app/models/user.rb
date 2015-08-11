class User < ActiveRecord::Base
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :omniauthable

    USER_ROLES = %w(player admin)

    validates :role, inclusion: {in:  USER_ROLES}

    has_one :citizen

    blogs
    acts_as_commontator

    USER_ROLES.each do |role|
    	define_method("#{role}?") do
  			role?(role)
	  	end
	  	scope "#{role.pluralize}".to_sym, -> { where(role: role)}
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
