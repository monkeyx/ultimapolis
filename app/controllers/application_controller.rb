class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	rescue_from CanCan::AccessDenied do |exception|
    	redirect_to main_app.new_user_session_path, :alert => exception.message
  	end

	def after_sign_in_path_for(resource)
		sign_in_url = new_user_session_url
		if request.referer == sign_in_url
			super
		else
			stored_location_for(resource) || request.referer || root_path
		end
	end

  	def current_citizen
  		current_user && current_user.citizen
  	end

  	def format_turn(n)
		Global.format_turn(n)
	end

	def test_exception_notifier
		raise 'This is a test. This is only a test.'
	end
end
