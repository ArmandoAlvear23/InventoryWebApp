class EaPointsController < ApplicationController
  before_action :set_ea_point, only: [:show, :edit, :update, :destroy]

  # GET /ea_points
  # GET /ea_points.json
  def index
    @es_perimeters = EsPerimeter.all
    @bes_cyber_assets = BesCyberAsset.all
    @ea_points = EaPoint.all
    
    @feap = initialize_filterrific(
      EaPoint,
      params[:filterrific],
      select_options: {
        sorted_by: EaPoint.options_for_sorted_by
      },
      persistence_id: false,
      default_filter_params: {},
      available_filters: [:sorted_by, :search_query, :with_cyber_asset_id, :with_esp_id],
      ) or return

    @ea_points = @feap.find.paginate(:page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html
      format.js

      format.csv { send_data EaPoint.all.to_csv }
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /ea_points/1
  # GET /ea_points/1.json
  def show
    @access_list_to_ea_points = AccessListToEaPoint.all
  end

  # GET /ea_points/new
  def new
    @ea_point = EaPoint.new
    @ea_points = EaPoint.all
    @bes_cyber_assets = BesCyberAsset.all
    @es_perimeters = EsPerimeter.all
  end

  # GET /ea_points/1/edit
  def edit
    @ea_points = EaPoint.all
    @bes_cyber_assets = BesCyberAsset.all
    @es_perimeters = EsPerimeter.all 
  end

  # POST /ea_points
  # POST /ea_points.json
  def create
    @ea_point = EaPoint.new(ea_point_params)

    respond_to do |format|
      if @ea_point.save
        format.html { redirect_to @ea_point, notice: 'Electronic Access Point was successfully created!' }
        format.json { render :show, status: :created, location: @ea_point }
      else
        format.html { render :new }
        format.json { render json: @ea_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ea_points/1
  # PATCH/PUT /ea_points/1.json
  def update
    respond_to do |format|
      if @ea_point.update(ea_point_params)
        format.html { redirect_to @ea_point, notice: 'Electronic Access Point was successfully updated!' }
        format.json { render :show, status: :ok, location: @ea_point }
      else
        format.html { render :edit }
        format.json { render json: @ea_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ea_points/1
  # DELETE /ea_points/1.json
  def destroy
    @ea_point.destroy
    respond_to do |format|
      format.html { redirect_to ea_points_url, notice: 'Electronic Access Point was successfully deleted!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ea_point
      @ea_point = EaPoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ea_point_params
      params.require(:ea_point).permit(:eap_id, :eap_interface, :eap_ip, :eap_ca_eacms, :eap_esp_id, :eap_access_list)
    end
end