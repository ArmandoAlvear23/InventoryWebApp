class PspDiagramsToPsPerimetersController < ApplicationController
  before_action :set_psp_diagrams_to_ps_perimeter, only: [:show, :edit, :update, :destroy]

  # GET /psp_diagrams_to_ps_perimeters
  # GET /psp_diagrams_to_ps_perimeters.json
  def index
    if current_user.admin
    @psp_diagrams_to_ps_perimeters = PspDiagramsToPsPerimeter.all
    else 
      redirect_to "/ps_perimeters", notice: 'Page not available.'
    end
  end

  # GET /psp_diagrams_to_ps_perimeters/1
  # GET /psp_diagrams_to_ps_perimeters/1.json
  def show
    if current_user.admin
      @ps_perimeters = PsPerimeter.all
    else 
      redirect_to "/ps_perimeters", notice: 'Cannot edit uploaded document.'
    end
  end

  # GET /psp_diagrams_to_ps_perimeters/new
  def new
    @psp_diagrams_to_ps_perimeter = PspDiagramsToPsPerimeter.new
    @ps_perimeters = PsPerimeter.all
    @psp_diagrams_to_ps_perimeter.ps_pproof = params[:file]
  end

  # GET /psp_diagrams_to_ps_perimeters/1/edit
  def edit
    if current_user.admin
    @ps_perimeters = PsPerimeter.all
    else 
      redirect_to "/ps_perimeters", notice: 'Cannot edit uploaded document.'
    end
  end

  # POST /psp_diagrams_to_ps_perimeters
  # POST /psp_diagrams_to_ps_perimeters.json
  def create
    @psp_diagrams_to_ps_perimeter = PspDiagramsToPsPerimeter.new(psp_diagrams_to_ps_perimeter_params)

    respond_to do |format|
      if @psp_diagrams_to_ps_perimeter.save

        @psp_diagrams_to_ps_perimeter.ps_pproof.url # => '/url/to/file.png'
        @psp_diagrams_to_ps_perimeter.ps_pproof.current_path # => 'path/to/file.png'
        @psp_diagrams_to_ps_perimeter.ps_pproof_identifier # => 'file.png'

        format.html { redirect_to "/ps_perimeters", notice: 'Document has been uploaded.' }
        #format.html { redirect_to @psp_diagrams_to_ps_perimeter, notice: 'Psp diagrams to ps perimeter was successfully created.' }
        format.json { render :show, status: :created, location: @psp_diagrams_to_ps_perimeter }
      else
        format.html { render :new }
        format.json { render json: @psp_diagrams_to_ps_perimeter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /psp_diagrams_to_ps_perimeters/1
  # PATCH/PUT /psp_diagrams_to_ps_perimeters/1.json
  def update
    respond_to do |format|
      if @psp_diagrams_to_ps_perimeter.update(psp_diagrams_to_ps_perimeter_params)
        format.html { redirect_to @psp_diagrams_to_ps_perimeter, notice: 'Psp diagrams to ps perimeter was successfully updated.' }
        format.json { render :show, status: :ok, location: @psp_diagrams_to_ps_perimeter }
      else
        format.html { render :edit }
        format.json { render json: @psp_diagrams_to_ps_perimeter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /psp_diagrams_to_ps_perimeters/1
  # DELETE /psp_diagrams_to_ps_perimeters/1.json
  def destroy
    if current_user.admin
    @psp_diagrams_to_ps_perimeter.destroy
    respond_to do |format|
      format.html { redirect_to psp_diagrams_to_ps_perimeters_url, notice: 'Psp diagrams to ps perimeter was successfully destroyed.' }
      format.json { head :no_content }
    end
    else 
      redirect_to "/ps_perimeters", notice: 'Cannot delete uploaded document.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_psp_diagrams_to_ps_perimeter
      @psp_diagrams_to_ps_perimeter = PspDiagramsToPsPerimeter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def psp_diagrams_to_ps_perimeter_params
      params.require(:psp_diagrams_to_ps_perimeter).permit(:ps_pproof,:remove_ps_pproof,:psp_dia_file_name, :psp_dia_psp_id)
    end
end