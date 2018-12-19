class HomeController < ApplicationController
  def home
  	@bes_assets = BesAsset.all
  	@bes_cyber_assets = BesCyberAsset.all
  	@bes_cyber_systems = BesCyberSystem.all
  	@es_perimeters = EsPerimeter.all
  	@ea_points = EaPoint.all
  	@ps_perimeters = PsPerimeter.all
  end
end
