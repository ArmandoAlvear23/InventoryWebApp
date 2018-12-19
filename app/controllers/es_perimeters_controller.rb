class EsPerimetersController < ApplicationController
  before_action :set_es_perimeter, only: [:show, :edit, :update, :destroy]


  def download(temp = t)
        @t = NetworkTopToEsPerimeter.find(:id => temp)
        send_file "#{Rails.root}/storage/#{t.es_pproof.url}",:disposition => 'inline'
  end

  # GET /es_perimeters
  # GET /es_perimeters.json
  def index
    @es_perimeters = EsPerimeter.all
    
    @fesp = initialize_filterrific(
      EsPerimeter,
      params[:filterrific],
      select_options: {
        sorted_by: EsPerimeter.options_for_sorted_by
      },
      persistence_id: false,
      default_filter_params: {},
      available_filters: [:sorted_by, :search_query],
      ) or return

    @es_perimeters = @fesp.find.paginate(:page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html
      format.js

      format.csv { send_data EsPerimeter.all.to_csv }
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /es_perimeters/1
  # GET /es_perimeters/1.json
  def show
    @network_top_to_es_perimeters = NetworkTopToEsPerimeter.all    
  end

  # GET /es_perimeters/new
  def new
    @es_perimeter = EsPerimeter.new
    @bes_cyber_assets = BesCyberAsset.all
  end

  # GET /es_perimeters/1/edit
  def edit
    @bes_cyber_assets = BesCyberAsset.all

  end

  # POST /es_perimeters
  # POST /es_perimeters.json
  def create
    @es_perimeter = EsPerimeter.new(es_perimeter_params)
    esp_eacms_NA()

    respond_to do |format|
      if @es_perimeter.save
        #format.html {redirect_to new_network_top_to_es_perimeter_path}
        format.html { redirect_to @es_perimeter, notice: 'Electronic Security Point was successfully created!' }
        format.json { render :show, status: :created, location: @es_perimeter }
      else
        format.html { render :new }
        format.json { render json: @es_perimeter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /es_perimeters/1
  # PATCH/PUT /es_perimeters/1.json
  def update
    respond_to do |format|
      if @es_perimeter.update(es_perimeter_params)
        esp_eacms_NA()
        @es_perimeter.save
        format.html { redirect_to @es_perimeter, notice: 'Electronic Security Point was successfully updated!' }
        format.json { render :show, status: :ok, location: @es_perimeter }
      else
        format.html { render :edit }
        format.json { render json: @es_perimeter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /es_perimeters/1
  # DELETE /es_perimeters/1.json
  def destroy
    @es_perimeter.destroy
    respond_to do |format|
      format.html { redirect_to es_perimeters_url, notice: 'Electronic Security Point was successfully deleted!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_es_perimeter
      @es_perimeter = EsPerimeter.find(params[:id])
    end

    def esp_eacms_NA
      if @es_perimeter.esp_remote == "False"
        @es_perimeter.esp_eacms = "N/A"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def es_perimeter_params
      params.require(:es_perimeter).permit(:esp_id, :esp_description, :esp_network, :esp_conn, :esp_remote, :esp_eacms, :esp_topology)
    end
end
