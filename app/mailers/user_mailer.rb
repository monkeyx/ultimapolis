class UserMailer < MandrillMailer::TemplateMailer
	def registered(user)
		mandrill_mail(
			template: 'ultimapolis-registration',
			to: [user_to(user)],
			vars: global_vars,
			important: true,
			inline_css: true,
			recipient_vars: [user_vars(user)]
		)
	end

	def turn_report(user, turn)
		mandrill_mail(
			subject: "Ultimapolis Turn Report #{Global.format_turn(turn)}",
			template: 'ultimapolis-turn-report',
			to: [user_to(user)],
			vars: global_vars,
			important: true,
			inline_css: true,
			recipient_vars: [user_vars(user, {
				'TURN' => Global.format_turn(turn),
				'TURN_REPORTS' => TurnReport.for_citizen_or_any(user.citizen).for_turn(turn).map{|tr| tr.to_s}
			})]
		)
	end

	def global_vars
		{
			'HOME_PATH' => EMAIL_HOME_URL,
			'SIGN_IN_PATH' => '/users/sign_in'
		}
	end

	def user_vars(user, additional={})
		vars = {
			user.email =>
			{
				'CITIZEN_PATH' => user.citizen_path
			}
		}
		unless additional.empty?
			additional.keys.each do |key|
				vars[user.email][key] = additional[key]
			end
		end
		vars
	end

	def user_to(user)
		{email: user.email, name: user.username }
	end
end