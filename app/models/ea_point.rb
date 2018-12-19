class EaPoint < ApplicationRecord

	 def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      EaPoint.all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

	filterrific(
		default_filter_params: { sorted_by: 'created_at_asc'},
		available_filters: [
			:sorted_by,
			:search_query,
			:with_cyber_asset_id,
			:with_esp_id,
		]
		)


	scope :with_cyber_asset_id, lambda { |types|
		where(eap_ca_eacms: [*types])
	}

	scope :with_esp_id, lambda { |types|
		where(eap_esp_id: [*types])
	}

	scope :search_query, lambda { |query|
		return nil if query.blank?
		terms = query.downcase.split(/\s+/)
		terms = terms.map { |e| ('%'+e.gsub('*','%')+'%').gsub(/%+/, '%') }
		num_or_conds = 4
		where(
			terms.map{
				or_clauses = [
					"LOWER(ea_points.eap_id) LIKE ?",
					"LOWER(ea_points.eap_ip) LIKE ?",
					"LOWER(ea_points.eap_ca_eacms) LIKE ?",
					"LOWER(ea_points.eap_esp_id) LIKE ?"
				].join( ' OR ')
				"(#{ or_clauses })"
			}.join(' AND '),
			*terms.map { |e| [e] * num_or_conds }.flatten
			)
	}

	scope :sorted_by, lambda { |sort_option|
		direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
		case sort_option.to_s
		#EAP
		when /^eap_id_s_/
			order("LOWER(ea_points.eap_id) #{ direction }")
		#Cyber Asset ID of EACMS
		when /^ca_eacms_/
			order("LOWER(ea_points.eap_ca_eacms) #{ direction }")
		#Electronic Security Perimter ID
		when /^esp_id_/
			order("LOWER(ea_points.eap_esp_id) #{ direction }")
		#Created At
		when /^created_at_/
			order("ea_points.created_at #{ direction }")
		#Updated At
		when /^updated_at_/
			order("ea_points.updated_at #{ direction }")
		else
			raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect}")
		end
	}

	def self.options_for_sorted_by
		[
			['EAP (a-z)', 'eap_id_s_asc'],
			['EAP (z-a)', 'eap_id_s_desc'],
			['CA ID of EACMS (a-z)', 'ca_eacms_asc'],
			['CA ID of EACMS (z-a)', 'ca_eacms_desc'],
			['ESP ID (a-z)', 'esp_id_asc'],
			['ESP ID (z-a)', 'esp_id_desc'],
			['Updated At (newest)', 'updated_at_desc'],
			['Updated At (oldest)', 'updated_at_asc'],
			['Created At (newest)', 'created_at_desc'],
			['Created At (oldest)', 'created_at_asc']
		]
	end

end
