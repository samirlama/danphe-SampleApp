module TestHelpers
	module Authentication
		def login(user)
			visit '/login'
			fill_in 'session_email', with: user.email
			fill_in 'session_password', with: user.password
			click_button 'Login'
		end
	end
end
