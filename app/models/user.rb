class User < ActiveRecord::Base
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :omniauthable

    USER_ROLES = %w(player admin)

    validates :role, inclusion: {in:  USER_ROLES}

    has_one :citizen

    USER_ROLES.each do |role|
    	define_method("#{role}?") do
  			role?(role)
	  	end
	  	scope "#{role.pluralize}".to_sym, -> { where(role: role)}
    end

    def role?(role)
    	self.role == role
    end
end
