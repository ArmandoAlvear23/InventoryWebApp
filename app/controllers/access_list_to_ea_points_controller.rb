class AccessListToEaPointsController < ApplicationController
  before_action :set_access_list_to_ea_point, only: [:show, :edit, :update, :destroy]

  # GET /access_list_to_ea_points
  # GET /access_list_to_ea_points.json
  def index
    if current_user.admin
    @access_list_to_ea_points = AccessListToEaPoint.all
    else 
      redirect_to "/ea_points", notice: 'Page not available.'
    end
  end

  # GET /access_list_to_ea_points/1
  # GET /access_list_to_ea_points/1.json
  def show
    if current_user.admin
      @ea_points = EaPoint.all
    else 
      redirect_to "/ea_points", notice: 'Cannot edit uploaded document.'
    end
  end

  # GET /access_list_to_ea_points/new
  def new
    @access_list_to_ea_point = AccessListToEaPoint.new
    #@ea_points = EaPoint.all
    @access_list_to_ea_point.ea_pproof = params[:file]
  end

  # GET /access_list_to_ea_points/1/edit
  def edit
    if current_user.admin
    @ea_points = EaPoint.all
    else 
      redirect_to "/ea_points", notice: 'Cannot edit uploaded document.'
    end
  end

  # POST /access_list_to_ea_points
  # POST /access_list_to_ea_points.json
  def create
    @access_list_to_ea_point = AccessListToEaPoint.new(access_list_to_ea_point_params)

    respond_to do |format|
      if @access_list_to_ea_point.save

        @access_list_to_ea_point.ea_pproof.url # => '/url/to/file.png'
        @access_list_to_ea_point.ea_pproof.current_path # => 'path/to/file.png'
        @access_list_to_ea_point.ea_pproof_identifier # => 'file.png'

        format.html { redirect_to "/ea_points", notice: 'Document has been uploaded.' }
        #format.html { redirect_to @access_list_to_ea_point, notice: 'Access list to ea point was successfully created.' }
        format.json { render :show, status: :created, location: @access_list_to_ea_point }
      else
        format.html { render :new }
        format.json { render json: @access_list_to_ea_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_list_to_ea_points/1
  # PATCH/PUT /access_list_to_ea_points/1.json
  def update
    respond_to do |format|
      if @access_list_to_ea_point.update(access_list_to_ea_point_params)

        @access_list_to_ea_point.ea_pproof.url # => '/url/to/file.png'
        @access_list_to_ea_point.ea_pproof.current_path # => 'path/to/file.png'
        @access_list_to_ea_point.ea_pproof_identifier # => 'file.png'

        #format.html { redirect_to "/ea_points", notice: 'Document has been uploaded.' }
        format.html { redirect_to @access_list_to_ea_point, notice: 'Access list to ea point was successfully updated.' }
        format.json { render :show, status: :ok, location: @access_list_to_ea_point }
      else
        format.html { render :edit }
        format.json { render json: @access_list_to_ea_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_list_to_ea_points/1
  # DELETE /access_list_to_ea_points/1.json
  def destroy
    if current_user.admin
    @access_list_to_ea_point.destroy
    respond_to do |format|
      format.html { redirect_to access_list_to_ea_points_url, notice: 'Access list to ea point was successfully destroyed.' }
      format.json { head :no_content }
    end
    else 
      redirect_to "/ea_points", notice: 'Cannot delete uploaded document.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_access_list_to_ea_point
      @access_list_to_ea_point = AccessListToEaPoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_list_to_ea_point_params
      params.require(:access_list_to_ea_point).permit(:ea_pproof, :remove_ea_pproof, :al_file_name, :al_eap_id)
    end
end
