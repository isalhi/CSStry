class SessionsController < ApplicationController
  def new
  end
    
    def create
        user = User.authenticate(params[:session][:email],
                                 params[:session][:password])
        if user.nil?
            flash.now[:error] = "Invalid password/email combination."
            @titre = "Identifier"
            render 'new'
            else
            sign_in user
            redirect_back_or user
        end
    end
    
    def destroy
        sign_out
        redirect_to home_path
    end
end
