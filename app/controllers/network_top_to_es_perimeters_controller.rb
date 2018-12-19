class NetworkTopToEsPerimetersController < ApplicationController
  before_action :set_network_top_to_es_perimeter, only: [:show, :edit, :update, :destroy]


  # GET /network_top_to_es_perimeters
  # GET /network_top_to_es_perimeters.json
  def index

    if current_user.admin
      @network_top_to_es_perimeters = NetworkTopToEsPerimeter.all
    else 
      redirect_to "/es_perimeters", notice: 'Page not available.'
    end

  end

  # GET /network_top_to_es_perimeters/1
  # GET /network_top_to_es_perimeters/1.json
  def show
    if current_user.admin
      @es_perimeters = EsPerimeter.all
    else 
      redirect_to "/es_perimeters", notice: 'Cannot edit uploaded document.'
    end
  end

  # GET /network_top_to_es_perimeters/new
  def new
    @network_top_to_es_perimeter = NetworkTopToEsPerimeter.new
    @es_perimeters = EsPerimeter.all
    @network_top_to_es_perimeter.es_pproof = params[:file]
  end

  # GET /network_top_to_es_perimeters/1/edit
  def edit
    if current_user.admin
      @es_perimeters = EsPerimeter.all
    else 
      redirect_to "/es_perimeters", notice: 'Cannot edit uploaded document.'
    end

  end

  # POST /network_top_to_es_perimeters
  # POST /network_top_to_es_perimeters.json
  def create
    @network_top_to_es_perimeter = NetworkTopToEsPerimeter.new(network_top_to_es_perimeter_params)

    respond_to do |format|
      if @network_top_to_es_perimeter.save

        @network_top_to_es_perimeter.es_pproof.url # => '/url/to/file.png'
        @network_top_to_es_perimeter.es_pproof.current_path # => 'path/to/file.png'
        @network_top_to_es_perimeter.es_pproof_identifier # => 'file.png'

        format.html { redirect_to "/es_perimeters", notice: 'Document has been uploaded.' }
        #format.html { redirect_to @network_top_to_es_perimeter, notice: 'Network top to es perimeter was successfully created.' }
        format.json { render :show, status: :created, location: @network_top_to_es_perimeter }
      else
        format.html { render :new }
        format.json { render json: @network_top_to_es_perimeter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /network_top_to_es_perimeters/1
  # PATCH/PUT /network_top_to_es_perimeters/1.json
  def update

    if current_user.admin
      respond_to do |format|
      if @network_top_to_es_perimeter.update(network_top_to_es_perimeter_params)
        format.html { redirect_to @network_top_to_es_perimeter, notice: 'Network top to es perimeter was successfully updated.' }
        format.json { render :show, status: :ok, location: @network_top_to_es_perimeter }
      else
        format.html { render :edit }
        format.json { render json: @network_top_to_es_perimeter.errors, status: :unprocessable_entity }
      end
    end
    else 
      redirect_to "/es_perimeters", notice: 'Cannot edit uploaded document.'
    end

  end

  # DELETE /network_top_to_es_perimeters/1
  # DELETE /network_top_to_es_perimeters/1.json
  def destroy
    if current_user.admin
      @network_top_to_es_perimeter.destroy
    respond_to do |format|
      format.html { redirect_to network_top_to_es_perimeters_url, notice: 'Network top to es perimeter was successfully destroyed.' }
      format.json { head :no_content }
    end
    else 
      redirect_to "/es_perimeters", notice: 'Cannot delete uploaded document.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_network_top_to_es_perimeter
      @network_top_to_es_perimeter = NetworkTopToEsPerimeter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def network_top_to_es_perimeter_params
      params.require(:network_top_to_es_perimeter).permit(:es_pproof,:remove_es_pproof,:nt_file_name, :nt_esp_id)
    end
end
