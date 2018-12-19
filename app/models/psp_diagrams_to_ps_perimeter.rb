class PspDiagramsToPsPerimeter < ApplicationRecord
	mount_uploader :ps_pproof, PsPproofUploader
	serialize :ps_pproof, JSON 
end
