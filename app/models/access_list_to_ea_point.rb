class AccessListToEaPoint < ApplicationRecord
	mount_uploader :ea_pproof, EaPproofUploader
	serialize :ea_pproof, JSON 
end
