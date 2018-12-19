class BesCyberAssetsController < ApplicationController
  before_action :set_bes_cyber_asset, only: [:show, :edit, :update, :destroy]

  # GET /bes_cyber_assets
  # GET /bes_cyber_assets.json

  
  def index

    @bes_assets = BesAsset.all
    @bes_cyber_systems = BesCyberSystem.all
    @bes_cyber_assets = BesCyberAsset.all

    @f = initialize_filterrific(
      BesCyberAsset,
      params[:filterrific],
      select_options: {
        sorted_by: BesCyberAsset.options_for_sorted_by
      },
      persistence_id: false,
      default_filter_params: {},
      available_filters: [:sorted_by, :search_query, :with_asset_id, :with_impact_rating, :with_ca_class, :with_ca_function, :with_os_firmware, :with_logging],
      ) or return

    @bes_cyber_assets = @f.find.paginate(:page => params[:page], :per_page => 100)

    respond_to do |format|
      format.html
      format.js

      format.csv { send_data BesCyberAsset.all.to_csv }
    end

    rescue ActiveRecord::RecordNotFound => e
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
  end


  # GET /bes_cyber_assets/1
  # GET /bes_cyber_assets/1.json
  def show
    add_rating()
    add_cip_005()
    @bes_cyber_asset.save
  end

  # GET /bes_cyber_assets/new
  def new
    @bes_cyber_asset = BesCyberAsset.new
    @bes_cyber_assets = BesCyberAsset.all
    @es_perimeters = EsPerimeter.all
    @ps_perimeters = PsPerimeter.all
    
    @bes_assets = BesAsset.all
    @bes_cyber_systems = BesCyberSystem.all
    @bes_cyber_asset.proof = params[:file]
  end

  # GET /bes_cyber_assets/1/edit
  def edit
    @bes_assets = BesAsset.all
    @bes_cyber_systems = BesCyberSystem.all
    @bes_cyber_assets  = BesCyberAsset.all
    @es_perimeters = EsPerimeter.all
    @ps_perimeters = PsPerimeter.all
  end

  # POST /bes_cyber_assets
  # POST /bes_cyber_assets.json
  def create
    @bes_cyber_asset = BesCyberAsset.new(bes_cyber_asset_params)
    @bes_cyber_assets = BesCyberAsset.all
    @bes_cyber_systems = BesCyberSystem.all
    @bes_assets = BesAsset.all
    @es_perimeters = EsPerimeter.all
    @es_perimeters = EsPerimeter.all
    @ps_perimeters = PsPerimeter.all
    bcs_login_NA()
    other_NA_CAF()
    other_NA_OS()
    save_as_NA()

    respond_to do |format|
      if @bes_cyber_asset.save

        @bes_cyber_asset.proof.url # => '/url/to/file.png'
        @bes_cyber_asset.proof.current_path # => 'path/to/file.png'
        @bes_cyber_asset.proof_identifier # => 'file.png'

        format.html { redirect_to @bes_cyber_asset, notice: 'Cyber Asset was successfully created!' }
        format.json { render :show, status: :created, location: @bes_cyber_asset }
      else
        format.html { render :new }
        format.json { render json: @bes_cyber_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bes_cyber_assets/1
  # PATCH/PUT /bes_cyber_assets/1.json
  def update

    #@bes_cyber_asset = BesCyberAsset.new(bes_cyber_asset_params)
    @bes_cyber_assets = BesCyberAsset.all

    @bes_cyber_systems = BesCyberSystem.all

    @bes_assets = BesAsset.all

    @es_perimeters = EsPerimeter.all
    @ps_perimeters = PsPerimeter.all


    respond_to do |format|
      if @bes_cyber_asset.update(bes_cyber_asset_params)


        @bes_cyber_asset.proof.url # => '/url/to/file.png'
        @bes_cyber_asset.proof.current_path # => 'path/to/file.png'
        @bes_cyber_asset.proof_identifier # => 'file.png'
        bcs_login_NA()
        other_NA_CAF()
        other_NA_OS()
        save_as_NA()
        @bes_cyber_asset.save
        format.html { redirect_to @bes_cyber_asset, notice: 'Cyber Asset was successfully updated!' }
        format.json { render :show, status: :ok, location: @bes_cyber_asset }
      else
        format.html { render :edit }
        format.json { render json: @bes_cyber_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bes_cyber_assets/1
  # DELETE /bes_cyber_assets/1.json
  def destroy
    @bes_cyber_asset.destroy
    respond_to do |format|
      format.html { redirect_to bes_cyber_assets_url, notice: 'Cyber Asset was successfully deleted!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bes_cyber_asset
      @bes_cyber_asset = BesCyberAsset.find(params[:id])
    end


    def add_rating
      @bes_cyber_systems = BesCyberSystem.all
      @bes_cyber_systems.each do |c| 
        if c.BES_cyber_system == @bes_cyber_asset.bcs_id
          if c.impact_rating_BCS == "High"
            @bes_cyber_asset.impact_rating = "High"
          else
            if c.impact_rating_BCS == "Medium"
              @bes_cyber_asset.impact_rating = "Medium"
            else
              if c.impact_rating_BCS == "Low"
                @bes_cyber_asset.impact_rating = "Low"
              else
                if c.impact_rating_BCS == "N/A"
                  @bes_cyber_asset.impact_rating = "N/A"
                else
                  @bes_cyber_asset.impact_rating = "ERROR"
                end
              end
            end
          end
        end
      end
    end

    def add_cip_005
      if @bes_cyber_asset.ca_classification =="BCA" or @bes_cyber_asset.ca_classification=="PCA" or @bes_cyber_asset.ca_classification=="CA in BCS" and @bes_cyber_asset.ca_dial_up =="True"
        @bes_cyber_asset.cip_005 = "Yes"
      else
        if @bes_cyber_asset.ca_classification =="EACMS" or @bes_cyber_asset.ca_classification=="PACS" or @bes_cyber_asset.ca_dial_up=="False"
          @bes_cyber_asset.cip_005 = "No" 
        else
          @bes_cyber_asset.cip_005 = "ERROR: CLASSIFICATION UNDEFINED"
        end
      end
    end


    def bcs_login_NA
      if @bes_cyber_asset.ca_bcs_login == "CA" or @bes_cyber_asset.ca_bcs_login == "None"
        @bes_cyber_asset.bcs_login = "N/A"
      end
    end

    def other_NA_CAF
      if @bes_cyber_asset.ca_function != "Other (please specify)"
        @bes_cyber_asset.ca_other = "N/A"
      end
    end

    def other_NA_OS
      if @bes_cyber_asset.os_firmware != "Other (please specify)"
        @bes_cyber_asset.os_other = "N/A"
      end
    end


    def save_as_NA
      if @bes_cyber_asset.esp_identifier == ""
        @bes_cyber_asset.esp_identifier = "N/A"
      end
      if @bes_cyber_asset.ca_psp == ""
        @bes_cyber_asset.ca_psp = "N/A"
      end
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def bes_cyber_asset_params
      params.require(:bes_cyber_asset).permit(:proof, :remove_proof, :ca_id, :ca_classification, :bcs_id, :impact_rating, :asset_id, :protocol, :ip_address, :esp_identifier, :ca_dial_up, :cip_005, :ca_ira, :ca_psp, :ca_bcs_login, :bcs_login, :log_collector, :activation_date, :deactivation_date, :ca_function, :ca_other, :ca_vendor, :ca_model, :os_firmware, :os_other, :external_conn, :system_logging, :alerting, :reg_entity_ncr, :region, :function)
    end
end
