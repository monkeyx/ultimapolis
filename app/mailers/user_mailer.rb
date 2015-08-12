class UserMailer < MandrillMailer::TemplateMailer
	default from: EMAIL_DEFAULT_FROM

	def registered(user)
		mandrill_mail(
			template: 'ultimapolis-registration',
			to: [{email: user.email, name: user.username }],
			vars: {
				'HOME_PATH' => root_url
			},
			important: true,
			inline_css: true,
			recipient_vars: {
				user.email =>
				{
					'CITIZEN_PATH' => user.citizen_path
				}
			}
		)
	end
end