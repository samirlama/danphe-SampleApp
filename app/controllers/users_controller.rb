class UsersController < ApplicationController
    # before_action :logged_in_user, only: %i[edit update show]
    before_action :correct_user, only: %i[edit update show]
    include SessionsHelper
    
    def index
        @users = User.where(activated: true).paginate(page: params[:page], per_page: 5)
    end
    def new
        @user = User.new
    end
    
    def show
        @user = User.find(params[:id])
        @micro = @user.microposts.paginate(page: params[:page], per_page: 10)
    end

    def edit 
        @user = User.find(params[:id])
    end

    def update 
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = "Profile was edited successfully"
            redirect_to @user
        else
            render 'new'
        end
    end

    def create
        @user = User.create(user_params)
        UserMailer.account_activation(@user).deliver_now
        if @user.valid? && @user.activated?
            log_in @user
            flash[:success] = "Welcome #{@user.name} to the sample App"
            redirect_to @user
        else
            flash[:info] = "PLease check you email for email activation"
            redirect_to '/'
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:success] = "User is successfully deleted"
        redirect_to "/"
    end

    private
    def user_params
        params.require(:user).permit(:name , :email , :password , :password_confirmation)
    end

   
    def correct_user
        @user = User.find_by(id: params[:id])
        redirect_to current_user unless current_user?(@user)
    end
    
   
end
