class NetworkTopToEsPerimeter < ApplicationRecord
	mount_uploader :es_pproof, EsPproofUploader
	serialize :es_pproof, JSON 
end
