module ApplicationHelper
    def page_title(title = '')
        current_page = title
        if title.present?
            @full_title = current_page + ' ' + '|' + ' ' + "The Beginner Rails App"
        else
            @full_title = "The Beginner Rails App"
        end
        @full_title
    end

    def log_in(user)
        session[:user_id] = user.id
    end

    def log_in_as(user, remember_me: '1')
		post login_path, params: {session: {
			email: user.email,
			password: user.password,
			remember_me: remember_me
		}}
	end
end
