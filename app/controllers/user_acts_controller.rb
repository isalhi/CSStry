class UserActsController < ApplicationController
  before_action :set_user_act, only: [:show, :edit, :update, :destroy]

  # GET /user_acts
  # GET /user_acts.json
  def index
    @user_acts = UserAct.all
  end

  # GET /user_acts/1
  # GET /user_acts/1.json
  def show
  end

  # GET /user_acts/new
  def new
    @user_act = UserAct.new
  end

  # GET /user_acts/1/edit
  def edit
  end

  # POST /user_acts
  # POST /user_acts.json
  def create
    @user_act = UserAct.new
    @user_acts = UserAct.all
    @user_act.id_activity=params[:id_activity]
    @user_act.id_user=params[:id_user]

    
    @activity = Activity.find(@user_act.id_activity)

    notRepeated = true;

    @user_acts.all.each do |e|
      if @user_act.id_user == e.id_user
        if @user_act.id_activity == e.id_activity
          notRepeated = false
        end
      end
    end
    
    
    respond_to do |format|
      if @user_act.save
        format.html { redirect_to activity_path(@user_act.id_activity), notice: "You're going to #{@activity.name}" }
        format.json { render action: 'show', status: :created, location: @user_act }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_act.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_acts/1
  # PATCH/PUT /user_acts/1.json
  def update
    respond_to do |format|
      if @user_act.update(user_act_params)
        format.html { redirect_to activity_path(@user_act.id_activity), notice: 'User act was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_act.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_acts/1
  # DELETE /user_acts/1.json
  def destroy
    @activity = Activity.find(@user_act.id_activity)
    @user_act.destroy
    respond_to do |format|
      format.html { redirect_to activity_path(@user_act.id_activity), notice: "You're no longer going to #{@activity.name}" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_act
      @user_act = UserAct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_act_params
      params.require(:user_act).permit(:id_activity, :id_user)
    end
end
