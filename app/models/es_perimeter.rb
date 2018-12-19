class EsPerimeter < ApplicationRecord

	 def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      EsPerimeter.all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

	filterrific(
		default_filter_params: { sorted_by: 'created_at_asc'},
		available_filters: [
			:sorted_by,
			:search_query,
		]
		)

	scope :search_query, lambda { |query|
		return nil if query.blank?
		terms = query.downcase.split(/\s+/)
		terms = terms.map { |e| ('%'+e.gsub('*','%')+'%').gsub(/%+/, '%') }
		num_or_conds = 4
		where(
			terms.map{
				or_clauses = [
					"LOWER(es_perimeters.esp_id) LIKE ?",
					"LOWER(es_perimeters.esp_description) LIKE ?",
					"LOWER(es_perimeters.esp_network) LIKE ?",
					"LOWER(es_perimeters.esp_eacms) LIKE ?"
				].join( ' OR ')
				"(#{ or_clauses })"
			}.join(' AND '),
			*terms.map { |e| [e] * num_or_conds }.flatten
			)
	}

	scope :sorted_by, lambda { |sort_option|
		direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
		case sort_option.to_s
		#ESP
		when /^esp_/
			order("LOWER(es_perimeters.esp_id) #{ direction }")
		#EACMS
		when /^eacms_/
			order("LOWER(esp_eacms) #{ direction }")
		#Created At
		when /^created_at_/
			order("es_perimeters.created_at #{ direction }")
		#Updated At
		when /^updated_at_/
			order("es_perimeters.updated_at #{ direction }")
		else
			raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect}")
		end
	}

	def self.options_for_sorted_by
		[
			['ESP ID (a-z)', 'esp_asc'],
			['ESP ID (z-a)', 'esp_desc'],
			['EACMS (a-z)', 'eacms_asc'],
			['EACMS (z-a)', 'eacms_desc'],
			['Updated At (newest)', 'updated_at_desc'],
			['Updated At (oldest)', 'updated_at_asc'],
			['Created At (newest)', 'created_at_desc'],
			['Created At (oldest)', 'created_at_asc']
		]
	end

end
