class PsPerimeter < ApplicationRecord

	 def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      PsPerimeter.all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

	filterrific(
		default_filter_params: { sorted_by: 'created_at_asc'},
		available_filters: [
			:sorted_by,
			:search_query,
			:with_location,
			:with_asset_id,
		]
		)


	scope :with_location, lambda { |types|
		where(psp_location: [*types])
	}

	scope :with_asset_id, lambda { |types|
		where(psp_asset_id: [*types])
	}

	scope :search_query, lambda { |query|
		return nil if query.blank?
		terms = query.downcase.split(/\s+/)
		terms = terms.map { |e| ('%'+e.gsub('*','%')+'%').gsub(/%+/, '%') }
		num_or_conds = 4
		where(
			terms.map{
				or_clauses = [
					"LOWER(ps_perimeters.psp_id) LIKE ?",
					"LOWER(ps_perimeters.psp_description) LIKE ?",
					"LOWER(ps_perimeters.psp_location) LIKE ?",
					"LOWER(ps_perimeters.psp_asset_id) LIKE ?"
				].join( ' OR ')
				"(#{ or_clauses })"
			}.join(' AND '),
			*terms.map { |e| [e] * num_or_conds }.flatten
			)
	}

	scope :sorted_by, lambda { |sort_option|
		direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
		case sort_option.to_s
		#PSP ID
		when /^psp_id/
			order("LOWER(ps_perimeters.psp_id) #{ direction }")
		#PSP Location
		when /^psp_location/
			order("LOWER(ps_perimeters.psp_location) #{ direction }")
		#PSP Asset ID
		when /^psp_asset_id/
			order("LOWER(ps_perimeters.psp_asset_id) #{ direction }")
			#Created At
		when /^created_at_/
			order("ps_perimeters.created_at #{ direction }")
		#Updated At
		when /^updated_at_/
			order("ps_perimeters.updated_at #{ direction }")
		else
			raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect}")
		end
	}

	def self.options_for_sorted_by
		[
			['PSP ID (a-z)', 'psp_id_asc'],
			['PSP ID (z-a)', 'psp_id_desc'],
			['Location (a-z)', 'psp_location_asc'],
			['Location (z-a)', 'psp_location_desc'],
			['Asset ID (a-z)', 'psp_asset_id_asc'],
			['Asset ID (z-a)', 'psp_asset_id_desc'],
			['Updated At (newest)', 'updated_at_desc'],
			['Updated At (oldest)', 'updated_at_asc'],
			['Created At (newest)', 'created_at_desc'],
			['Created At (oldest)', 'created_at_asc']
		]
	end

end
