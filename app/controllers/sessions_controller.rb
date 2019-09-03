class SessionsController < ApplicationController
    include SessionsHelper
    def create
        debugger
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            if user.activated?
                log_in user
                params[:session][:remember_me] == '1' ? remember(user) : forget(user)
                redirect_back_or user
            else
                message = "Account not activated."
                message+= "Please check you email for activation link"
                flash[:danger] = message
            end
        else
            flash.now[:danger] = 'Invalid email/password combination'
            render 'new'
        end
    end

    def new 
    end

    def destroy
        log_out if logged_in?
        redirect_to root_path
    end
end
