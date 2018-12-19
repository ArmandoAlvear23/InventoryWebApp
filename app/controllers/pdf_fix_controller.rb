class PdfFixController < ActionController::Base

	def download
    	send_file("uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}", filename: "test.pdf", type: "application/pdf")
	end


end