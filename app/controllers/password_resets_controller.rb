class PasswordResetsController < ApplicationController
    before_action :get_user, only: %i[edit update]
    before_action :valid_user, only: %i[edit update]
    before_action :check_expiration, only: %i[edit update]
    include SessionsHelper
    def create
        @user = User.find_by(email: params[:password_reset][:email].downcase)
        debugger
        # if user && user.authenticated?
        if @user
            @user.create_reset_digest
            @user.send_password_reset_email
            flash[:info] = "email sent with password reset instruction"
            redirect_to root_path
        else
            flash[:danger] = "email not found"
            render 'new'
        end
    end

        def new
        end

        def edit
        end

        def update
            if params[:user][:password].empty?
                @user.errors.add(:password, 'cant be empty')
                render 'edit'
            elsif @user.update_attributes(user_params)
                log_in @user
                flash[:success] = "password reset"
                redirect_to @user
            else
                render 'edit'
            end
        end
        private
        def get_user
            @user = User.find_by(email: params[:email].downcase)
        end

        def valid_user
            unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
                redirect_to root_path
            end
        end

        def check_expiration
            if @user.password_reset_expired?
                flash[:info] = "Reset token has expired"
                redirect_to root_path
            end
        end

        def user_params
            params.require(:user).permit(:password, :password_confirmation)
        end
    

end
