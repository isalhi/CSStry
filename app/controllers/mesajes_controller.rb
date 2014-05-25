class MesajesController < ApplicationController
  before_action :set_mesaje, only: [:show, :edit, :update, :destroy]

  # GET /mesajes
  # GET /mesajes.json
  def index
    @mesajes = Mesaje.all
  end

  # GET /mesajes/1
  # GET /mesajes/1.json
  def show
  end

  # GET /mesajes/new
  def new
    @mesaje = Mesaje.new
  end

  # GET /mesajes/1/edit
  def edit
  end

  # POST /mesajes
  # POST /mesajes.json
  def create
    @mesaje = Mesaje.new(mesaje_params)
    @mesaje.id_creator = current_user[:id]

    respond_to do |format|
      if @mesaje.save
        format.html { redirect_to @mesaje, notice: 'Mesaje was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mesaje }
      else
        format.html { render action: 'new' }
        format.json { render json: @mesaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mesajes/1
  # PATCH/PUT /mesajes/1.json
  def update
    respond_to do |format|
      if @mesaje.update(mesaje_params)
        format.html { redirect_to @mesaje, notice: 'Mesaje was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mesaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mesajes/1
  # DELETE /mesajes/1.json
  def destroy
    @mesaje.destroy
    respond_to do |format|
      format.html { redirect_to mesajes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mesaje
      @mesaje = Mesaje.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mesaje_params
      params.require(:mesaje).permit(:id_activity, :title, :description)
    end
end
