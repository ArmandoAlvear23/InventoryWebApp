class PsPerimetersController < ApplicationController
  before_action :set_ps_perimeter, only: [:show, :edit, :update, :destroy]

  # GET /ps_perimeters
  # GET /ps_perimeters.json
  def index
    @ps_perimeters = PsPerimeter.all
    @bes_assets = BesAsset.all

    @fpsp = initialize_filterrific(
      PsPerimeter,
      params[:filterrific],
      select_options: {
        sorted_by: PsPerimeter.options_for_sorted_by
      },
      persistence_id: false,
      default_filter_params: {},
      available_filters: [:sorted_by, :search_query, :with_location, :with_asset_id],
      ) or return

    @ps_perimeters = @fpsp.find.paginate(:page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data PsPerimeter.all.to_csv }
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /ps_perimeters/1
  # GET /ps_perimeters/1.json
  def show
        @psp_diagrams_to_ps_perimeters = PspDiagramsToPsPerimeter.all
  end

  # GET /ps_perimeters/new
  def new
    @ps_perimeter = PsPerimeter.new
    @bes_assets = BesAsset.all
  end

  # GET /ps_perimeters/1/edit
  def edit
    @bes_assets = BesAsset.all
  end

  # POST /ps_perimeters
  # POST /ps_perimeters.json
  def create
    @ps_perimeter = PsPerimeter.new(ps_perimeter_params)
    add_location()
    respond_to do |format|
      if @ps_perimeter.save
        format.html { redirect_to @ps_perimeter, notice: 'Physical Security Perimeter was successfully created!' }
        format.json { render :show, status: :created, location: @ps_perimeter }
      else
        format.html { render :new }
        format.json { render json: @ps_perimeter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ps_perimeters/1
  # PATCH/PUT /ps_perimeters/1.json
  def update
    respond_to do |format|
      if @ps_perimeter.update(ps_perimeter_params)
        add_location()
        @ps_perimeter.save
        format.html { redirect_to @ps_perimeter, notice: 'Physical Security Perimeter was successfully updated!' }
        format.json { render :show, status: :ok, location: @ps_perimeter }
      else
        format.html { render :edit }
        format.json { render json: @ps_perimeter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ps_perimeters/1
  # DELETE /ps_perimeters/1.json
  def destroy
    @ps_perimeter.destroy
    respond_to do |format|
      format.html { redirect_to ps_perimeters_url, notice: 'Physical Security Perimeter was successfully deleted!' }
      format.json { head :no_content }
    end
  end

  def add_location
    @bes_assets = BesAsset.all
    @bes_assets.each do |b|
      if @ps_perimeter.psp_asset_id == b.asset_id
        @ps_perimeter.psp_location = b.location
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ps_perimeter
      @ps_perimeter = PsPerimeter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ps_perimeter_params
      params.require(:ps_perimeter).permit(:psp_id, :psp_description, :psp_location, :psp_asset_id, :psp_diagrams)
    end
end
