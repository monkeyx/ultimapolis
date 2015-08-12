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
		report_entries = TurnReport.for_citizen_or_any(user.citizen).for_turn(turn).map{|tr| tr.citizen ? tr.to_s : "#{tr.district}: #{tr}"}
		report_entries = ['No events to report'] if report_entries.empty?
		mandrill_mail(
			subject: "[Ultimapolis] #{Global.format_turn(turn)} Report",
			template: 'ultimapolis-turn-report',
			to: [user_to(user)],
			vars: global_vars,
			important: true,
			inline_css: true,
			recipient_vars: [user_vars(user, {
				'TURN' => Global.format_turn(turn),
				'TURN_REPORTS' => report_entries
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
				'CITIZEN' => user.citizen.to_s,
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