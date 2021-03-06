class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy, :correct_user]
    before_filter :authenticate, :only => [:edit, :update, :destroy, :index]
    before_filter :correct_user, :only => [:edit, :update, :destroy]
    before_filter :admin_user, :only => [:user_params_admin]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      @title = "Inscription"
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if admin_user?
      if @user.update(user_params_admin)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    else
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  # DELETE /users/1
  # DELETE /users/1.json
    # DELETE /users/1.json
    def destroy
        UserAct.all.each do |ua|
          if ua.id_user == @user.id
            ua.destroy
          end
        end

        Activity.all.each do |aa|
          if aa.id_creator == @user.id
            aa.destroy
          end
        end

        @user.destroy
        respond_to do |format|
            format.html { redirect_to users_url }
            format.json { head :no_content }
        end
    end

  

  private
    
   
    
    def correct_user
        redirect_to(home_path) unless current_user?(@user) or admin_user?
    end
            
   
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def admin_user?
      current_user.name == "administrator"
    end
    
    def admin_user
      !admin_user?
    end
    
    def user_params_admin
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end
    
end
