class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def show
        @user = User.find(params[:id])
    end
    def create
        @user = User.create(user_params)
        if @user.valid?
            flash[:success] = "Welcome #{@user.name} to the sample App"
            redirect_to @user
        else
            render 'new'
        end
    end

    private
    def user_params
        params.require(:user).permit(:name , :email , :password , :password_confirmation)
    end
end
