class BesCyberSystemsController < ApplicationController
  before_action :set_bes_cyber_system, only: [:show, :edit, :update, :destroy]

  # GET /bes_cyber_systems
  # GET /bes_cyber_systems.json
  def index
    @bes_assets = BesAsset.all
    
    @fa = initialize_filterrific(
      BesCyberSystem,
      params[:filterrific],
      select_options: {
        sorted_by: BesCyberSystem.options_for_sorted_by
      },
      persistence_id: false,
      default_filter_params: {},
      available_filters: [:sorted_by, :search_query, :with_bes_asset, :bes_system_yn, :impact_rating],
      ) or return

    @bes_cyber_systems = @fa.find.paginate(:page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html
      format.js

      format.csv { send_data BesCyberSystem.all.to_csv }
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /bes_cyber_systems/1
  # GET /bes_cyber_systems/1.json
  def show
    add_bes_system()
    add_impact_rating()
    fix_rating()
    @bes_cyber_system.save
  end

  # GET /bes_cyber_systems/new
  def new
    @bes_cyber_system = BesCyberSystem.new
    @bes_assets = BesAsset.all
  end

  # GET /bes_cyber_systems/1/edit
  def edit
    @bes_assets = BesAsset.all
  end

  # POST /bes_cyber_systems
  # POST /bes_cyber_systems.json
  def create
    @bes_cyber_system = BesCyberSystem.new(bes_cyber_system_params)

    respond_to do |format|
      if @bes_cyber_system.save
        format.html { redirect_to @bes_cyber_system, notice: 'Cyber System was successfully created!' }
        format.json { render :show, status: :created, location: @bes_cyber_system }
      else
        format.html { render :new }
        format.json { render json: @bes_cyber_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bes_cyber_systems/1
  # PATCH/PUT /bes_cyber_systems/1.json
  def update
    respond_to do |format|
      if @bes_cyber_system.update(bes_cyber_system_params)
        fix_rating()
        @bes_cyber_system.save
        format.html { redirect_to @bes_cyber_system, notice: 'Cyber System was successfully updated!' }
        format.json { render :show, status: :ok, location: @bes_cyber_system }
      else
        format.html { render :edit }
        format.json { render json: @bes_cyber_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bes_cyber_systems/1
  # DELETE /bes_cyber_systems/1.json
  def destroy
    @bes_cyber_system.destroy
    respond_to do |format|
      format.html { redirect_to bes_cyber_systems_url, notice: 'Cyber System was successfully deleted!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bes_cyber_system
      @bes_cyber_system = BesCyberSystem.find(params[:id])
    end

    def add_bes_system
      if @bes_cyber_system.q1 == "Yes" or @bes_cyber_system.q2 == "Yes" or @bes_cyber_system.q3 == "Yes" or @bes_cyber_system.q4 == "Yes" or @bes_cyber_system.q5 == "Yes" or @bes_cyber_system.q6 == "Yes" or @bes_cyber_system.q7 == "Yes" or @bes_cyber_system.q8 == "Yes" or @bes_cyber_system.q9 == "Yes"
        @bes_cyber_system.BES_system = "Yes"
      else
        @bes_cyber_system.BES_system = "No"
      end
    end

    def add_impact_rating
      @b = BesAsset.all
      if @bes_cyber_system.BES_system == "Yes"
        @b.each do |p|
          if p.asset_id == @bes_cyber_system.BES_asset_BCS
            if p.high_impact == "True"
              @bes_cyber_system.impact_rating_BCS = "High"
            elsif p.medium_impact == "True"
              @bes_cyber_system.impact_rating_BCS = "Medium"
            elsif p.low_impact == "True"
              @bes_cyber_system.impact_rating_BCS = "Low"
            elsif (p.high_impact == "N/A") && (p.medium_impact == "N/A") && (p.low_impact == "N/A")
              @bes_cyber_system.impact_rating_BCS = "N/A"
            else
              @bes_cyber_system.impact_rating_BCS = "ERROR"
            end
          end
        end
        else
          @bes_cyber_system.impact_rating_BCS = "N/A"
      end

    end

    def fix_rating
      @bca = BesCyberAsset.all
      @bca.each do |b|
        if @bes_cyber_system.BES_cyber_system == b.bcs_id
          b.impact_rating = @bes_cyber_system.impact_rating_BCS 
          b.save
        end
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def bes_cyber_system_params
      params.require(:bes_cyber_system).permit(:BES_cyber_system, :BES_asset_BCS, :BES_system, :impact_rating_BCS, :justification, :q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9)
    end
end
