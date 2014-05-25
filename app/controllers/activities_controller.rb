class ActivitiesController < ApplicationController
    before_action :set_activity, :only => [:show, :edit, :update, :destroy, :set_user]
  before_filter :authenticate, :only => [:edit, :update, :destroy, :index]
  before_filter :correct_user, :only => [:edit, :update, :destroy]
    before_action :set_user, :only => [:correct_user, :show]
     respond_to :html

  # GET /activities
  # GET /activities.json
  def index
      
    @activities = Activity.all
    @user = current_user
      
      @search = Activity.search(params[:name])
      @users = params[:distinct].to_i.zero? ?
      @search.result :
      @search.result(distinct: true)
      
      respond_with @users
  end
 
  def search
      index
      render :index
      
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @mesaje = Mesaje.new
    @mesaje.id_creator = current_user.id
    @mesaje.id_activity = @activity.id
   
    
  end

  def unite
      @activity.user_act.new#(id_activity: @activity[:id], id_user: current_user[:id])
      respond_to do |format|
      if @user_act.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @activity }
      else
        format.html { render action: 'new' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /activities/new
  def new
    @activity = Activity.new
    
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
   @activity  = Activity.new(activity_params)
      @activity.id_creator = current_user[:id]
      
       respond_to do |format|
      if @activity.save
        
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @activity }
      else
        format.html { render action: 'new' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    UserAct.all.each do |ua|
      if ua.id_activity == @activity.id
        ua.destroy
      end
    end

    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end

  private
    
    def correct_user
        redirect_to(home_path) unless current_user.id == @activity.id_creator or admin_user?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
      @idmes = @activity.id
    end
    
    def admin_user?
      current_user.name == "administrator"
    end
    
    def set_user
        @user = User.find_by_id(@activity.id_creator)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:id_location, :name, :date, :duration, :id_cathegory, :description, :privacy, :accepted)
    end
end
