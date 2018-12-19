class BesAssetsController < ApplicationController
  before_action :set_bes_asset, only: [:show, :edit, :update, :destroy]

  # GET /bes_assets
  # GET /bes_assets.json
  def index

    @a = initialize_filterrific(
      BesAsset,
      params[:filterrific],
      select_options: {
        sorted_by: BesAsset.options_for_sorted_by,
        with_asset_type: BesAsset.options_for_select
      },
      persistence_id: false,
      default_filter_params: {},
      available_filters: [:sorted_by, :with_asset_type, :search_query, :with_comm_at, :with_high, :with_medium, :with_low],
      ) or return

    @bes_assets = @a.find.paginate(:page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data BesAsset.all.to_csv, :filename => "bes_asset" +"#{Time.now.strftime(".%m-%d-%Y")}" + ".csv" }
    end

    rescue ActiveRecord::RecordNotFound => e
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /bes_assets/1
  # GET /bes_assets/1.json
  def show
    add_rating()
    fix_bcs_bca_rating()
    @bes_asset.save
  end

  # GET /bes_assets/new
  def new
    @bes_asset = BesAsset.new
    #fix_questions()
    #@bes_asset.save
    @bes_asset.proof = params[:file]
  end

  # GET /bes_assets/1/edit
  def edit

  end

  # POST /bes_assets
  # POST /bes_assets.json
  def create
    @bes_asset = BesAsset.new(bes_asset_params)
    fix_questions()
    respond_to do |format|
      if @bes_asset.save
        @bes_asset.proof.url # => '/url/to/file.png'
        @bes_asset.proof.current_path # => 'path/to/file.png'
        @bes_asset.proof_identifier # => 'file.png'


        format.html { redirect_to @bes_asset, notice: 'Asset was successfully created!' }
        format.json { render :show, status: :created, location: @bes_asset }
      else
        format.html { render :new }
        format.json { render json: @bes_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bes_assets/1
  # PATCH/PUT /bes_assets/1.json
  def update
    questions_nil() #sets all to nil
    
    respond_to do |format|
      if @bes_asset.update(bes_asset_params) #gets all info and puts it to show
        @bes_asset.proof.url # => '/url/to/file.png'
        @bes_asset.proof.current_path # => 'path/to/file.png'
        @bes_asset.proof_identifier # => 'file.png'
        fix_questions() #puts N/A in nil parts
        fix_bcs_bca_rating()
        @bes_asset.save
        format.html { redirect_to @bes_asset, notice: 'Asset was successfully updated!' }
        format.json { render :show, status: :ok, location: @bes_asset }
      else
        format.html { render :edit }
        format.json { render json: @bes_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bes_assets/1
  # DELETE /bes_assets/1.json
  def destroy
    @bes_asset.destroy
    respond_to do |format|
      format.html { redirect_to bes_assets_url, notice: 'Asset was successfully deleted!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bes_asset
      @bes_asset = BesAsset.find(params[:id])
    end

    def add_rating
      @bes_asset.low_impact = ""
      @bes_asset.medium_impact = ""
      @bes_asset.high_impact = ""
      

      if @bes_asset.asset_type == "Control Center (CC)"

        if @bes_asset.cc1 == "Yes" or @bes_asset.cc2 == "Yes" or @bes_asset.cc3 == "Yes" or @bes_asset.cc4 == "Yes"
          @bes_asset.low_impact = "False"
          @bes_asset.medium_impact = "False"
          @bes_asset.high_impact = "True"
          
        elsif @bes_asset.cc5 == "Yes" or @bes_asset.cc6 == "Yes" or @bes_asset.cc7 == "Yes"
          @bes_asset.low_impact = "False"
          @bes_asset.medium_impact = "True"
          @bes_asset.high_impact = "False"

        elsif @bes_asset.cc8 == "Yes"
          @bes_asset.low_impact = "True"
          @bes_asset.medium_impact = "False"
          @bes_asset.high_impact = "False"

        end

      end


      if @bes_asset.asset_type == "Transmission Substation and Switchyard (TF)"

        if @bes_asset.tf1 == "Yes" or @bes_asset.tf2 == "Yes" or @bes_asset.tf3 == "Yes" or @bes_asset.tf4 == "Yes" or @bes_asset.tf5 == "Yes" or @bes_asset.tf6 == "Yes"
          @bes_asset.low_impact = "False"          
          @bes_asset.medium_impact = "True"
          @bes_asset.high_impact = "False"

        elsif @bes_asset.tf7 == "Yes" or @bes_asset.tf8 == "Yes"
          @bes_asset.low_impact = "True"
          @bes_asset.medium_impact = "False"
          @bes_asset.high_impact = "False"

        end

      end


      if @bes_asset.asset_type == "Generation Resource (G)"

        if @bes_asset.g1 == "Yes" or @bes_asset.g2 == "Yes" or @bes_asset.g3 == "Yes"
          @bes_asset.low_impact = "False"
          @bes_asset.medium_impact = "True"
          @bes_asset.high_impact = "False"

        elsif @bes_asset.g4 == "Yes" or @bes_asset.g5 == "Yes"
          @bes_asset.low_impact = "True"
          @bes_asset.medium_impact = "False"
          @bes_asset.high_impact = "False"

        end

      end


      if @bes_asset.asset_type == "Additional Asset (AA)"

        if @bes_asset.aa1 == "Yes" or @bes_asset.aa2 == "Yes"
          @bes_asset.low_impact = "False"
          @bes_asset.medium_impact = "True"
          @bes_asset.high_impact = "False"

        elsif @bes_asset.aa3 == "Yes"
          @bes_asset.low_impact = "True"
          @bes_asset.medium_impact = "False"
          @bes_asset.high_impact = "False"

        end

      end


      if @bes_asset.asset_type == "Distribution Resource (DP)"

        if @bes_asset.dp1 == "Yes"
          @bes_asset.low_impact = "True"
          @bes_asset.medium_impact = "False"
          @bes_asset.high_impact = "False"
        end

      end

      if @bes_asset.asset_type == nil
        @bes_asset.low_impact = @bes_asset.medium_impact = @bes_asset.high_impact = "N/A"
      end
      
    end

    def fix_questions
      a = "No"
      if @bes_asset.cc1 == a and  @bes_asset.cc2 == a and @bes_asset.cc3 == a and @bes_asset.cc4 == a and @bes_asset.cc5 == a and @bes_asset.cc6 == a and @bes_asset.cc7 == a and @bes_asset.cc8  == a
        @bes_asset.high_impact = "False"
        @bes_asset.medium_impact = "False"
        @bes_asset.low_impact = "False"
      end 

      if @bes_asset.cc1 == nil
        @bes_asset.cc1 = "N/A"
      end
      if @bes_asset.cc2 == nil
        @bes_asset.cc2 = "N/A"
      end
      if @bes_asset.cc3 == nil
        @bes_asset.cc3 = "N/A"
      end
      if @bes_asset.cc4 == nil
        @bes_asset.cc4 = "N/A"
      end
      if @bes_asset.cc5 == nil
        @bes_asset.cc5 = "N/A"
      end
      if @bes_asset.cc6 == nil
        @bes_asset.cc6 = "N/A"
      end
      if @bes_asset.cc7 == nil
        @bes_asset.cc7 = "N/A"
      end
      if @bes_asset.cc8 == nil
        @bes_asset.cc8 = "N/A"
      end
      if @bes_asset.tf1 == nil
        @bes_asset.tf1 = "N/A"
      end
      if @bes_asset.tf2 == nil
        @bes_asset.tf2 = "N/A"
      end
      if @bes_asset.tf3 == nil
        @bes_asset.tf3 = "N/A"
      end
      if @bes_asset.tf4 == nil
        @bes_asset.tf4 = "N/A"
      end
      if @bes_asset.tf5 == nil
        @bes_asset.tf5 = "N/A"
      end
      if @bes_asset.tf6 == nil
        @bes_asset.tf6 = "N/A"
      end
      if @bes_asset.tf7 == nil
        @bes_asset.tf7 = "N/A"
      end
      if @bes_asset.tf8 == nil
        @bes_asset.tf8 = "N/A"
      end
      if @bes_asset.g1 == nil
        @bes_asset.g1 = "N/A"
      end
      if @bes_asset.g2 == nil
        @bes_asset.g2 = "N/A"
      end
      if @bes_asset.g3 == nil
        @bes_asset.g3 = "N/A"
      end
      if @bes_asset.g4 == nil
        @bes_asset.g4 = "N/A"
      end
      if @bes_asset.g5 == nil
        @bes_asset.g5 = "N/A"
      end
      if @bes_asset.aa1 == nil
        @bes_asset.aa1 = "N/A"
      end
      if @bes_asset.aa2 == nil
        @bes_asset.aa2 = "N/A"
      end
      if @bes_asset.aa3 == nil
        @bes_asset.aa3 = "N/A"
      end
      if @bes_asset.dp1 == nil
        @bes_asset.dp1 = "N/A"
      end  

      #@bes_asset.cc1 = @bes_asset.cc2 = @bes_asset.cc3 = @bes_asset.cc4 = @bes_asset.cc5 = @bes_asset.cc6 = @bes_asset.cc7 = @bes_asset.cc8 = @bes_asset.tf1 = @bes_asset.tf2 = @bes_asset.tf3 = @bes_asset.tf4 = @bes_asset.tf5 = @bes_asset.tf6 = @bes_asset.tf7 = @bes_asset.tf8 = @bes_asset.g1 = @bes_asset.g2 = @bes_asset.g3 = @bes_asset.g4 = @bes_asset.g5 = @bes_asset.aa1 = @bes_asset.aa2 = @bes_asset.aa3 = @bes_asset.dp1 = "N/A"
    end

    def questions_nil
      @bes_asset.cc1 = @bes_asset.cc2 = @bes_asset.cc3 = @bes_asset.cc4 = @bes_asset.cc5 = @bes_asset.cc6 = @bes_asset.cc7 = @bes_asset.cc8 = @bes_asset.tf1 = @bes_asset.tf2 = @bes_asset.tf3 = @bes_asset.tf4 = @bes_asset.tf5 = @bes_asset.tf6 = @bes_asset.tf7 = @bes_asset.tf8 = @bes_asset.g1 = @bes_asset.g2 = @bes_asset.g3 = @bes_asset.g4 = @bes_asset.g5 = @bes_asset.aa1 = @bes_asset.aa2 = @bes_asset.aa3 = @bes_asset.dp1 = nil
    end

    def fix_bcs_bca_rating
      @bcs = BesCyberSystem.all
      @bca = BesCyberAsset.all

      @bcs.each do |b|
        if b.BES_system == "Yes"

          if @bes_asset.asset_id == b.BES_asset_BCS
            if @bes_asset.high_impact == "True"
              b.impact_rating_BCS = "High"
            elsif @bes_asset.medium_impact == "True"
              b.impact_rating_BCS = "Medium"
            elsif @bes_asset.low_impact == "True"
              b.impact_rating_BCS = "Low"
            elsif (@bes_asset.high_impact == "N/A") && (@bes_asset.medium_impact == "N/A") && (@bes_asset.low_impact == "N/A")
              b.impact_rating_BCS = "N/A"
            else 
              b.impact_rating_BCS = "ERROR"
            end
            b.save
          end

          @bca.each do |bca|
            if b.BES_cyber_system == bca.bcs_id
              bca.impact_rating = b.impact_rating_BCS
              bca.save
            end
          end

        end
      end
    end

    


    # Never trust parameters from the scary internet, only allow the white list through.
    def bes_asset_params
      params.require(:bes_asset).permit(:remove_proof, :proof, :asset_id, :asset_type, :description, :commission, :decommission, :location, :high_impact, :medium_impact, :low_impact, :erc, :dial_up, :region_op, :register_func, :cc1, :cc2, :cc3, :cc4, :cc5, :cc6, :cc7, :cc8, :tf1, :tf2, :tf3, :tf4, :tf5, :tf6, :tf7, :tf8, :g1, :g2, :g3, :g4, :g5, :aa1, :aa2, :aa3, :dp1)
    end
  end