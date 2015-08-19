class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	rescue_from CanCan::AccessDenied do |exception|
		session[:redirect_to] = request.original_url
		if current_user && current_user.citizen
			sign_out(:user) if current_user
			redirect_to main_app.new_user_session_path, :alert => exception.message
		elsif current_user
			redirect_to main_app.new_citizen_path, :alert => 'You need to have a citizen to continue.'
		else
			redirect_to main_app.new_user_session_path, :alert => 'Please login to continue.'
		end
  	end

	def after_sign_in_path_for(resource)
		sign_in_url = new_user_session_url
		if session[:redirect_to]
			path = session[:redirect_to]
			session[:redirect_to] = nil
			path
		elsif request.referer == sign_in_url
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
