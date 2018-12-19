class BesCyberSystem < ApplicationRecord

	 def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      BesCyberSystem.all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

	filterrific(
		default_filter_params: { sorted_by: 'created_at_asc'},
		available_filters: [
			:sorted_by,
			:search_query,
			:with_bes_asset,
			:bes_system_yn,
			:impact_rating,
		]
		)


	scope :with_bes_asset, lambda { |types|
		where(BES_asset_BCS: [*types])
	}

	scope :bes_system_yn, lambda { |types|
		where(BES_system: [*types])
	}

	scope :impact_rating, lambda { |types|
		where(impact_rating_BCS: [*types])
	}

	scope :search_query, lambda { |query|
		return nil if query.blank?
		terms = query.downcase.split(/\s+/)
		terms = terms.map { |e| ('%'+e.gsub('*','%')+'%').gsub(/%+/, '%') }
		num_or_conds = 5
		where(
			terms.map{
				or_clauses = [
					"LOWER(bes_cyber_systems.BES_cyber_system) LIKE ?",
					"LOWER(bes_cyber_systems.BES_asset_BCS) LIKE ?",
					"LOWER(bes_cyber_systems.BES_system) LIKE ?",
					"LOWER(bes_cyber_systems.impact_rating_BCS) LIKE ?",
					"LOWER(bes_cyber_systems.justification) LIKE ?"
				].join( ' OR ')
				"(#{ or_clauses })"
			}.join(' AND '),
			*terms.map { |e| [e] * num_or_conds }.flatten
			)
	}

	scope :sorted_by, lambda { |sort_option|
		direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
		case sort_option.to_s
		#BES Cyber System
		when /^systems_/
			order("LOWER(bes_cyber_systems.BES_cyber_system) #{ direction }")
		#BES Asset
		when /^bes_asset_ls_/
			order("LOWER(bes_cyber_systems.BES_asset_BCS) #{ direction }")
		#Justification
		when /^just_/
			order("LOWER(bes_cyber_systems.justification) #{ direction }")
		#Impact Rating
		when /^impact_rating_ls_/
			order("LOWER(bes_cyber_systems.impact_rating_BCS) #{ direction }")
		#Created At
		when /^created_at_/
			order("bes_cyber_systems.created_at #{ direction }")
		#Updated At
		when /^updated_at_/
			order("bes_cyber_systems.updated_at #{ direction }")
		else
			raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect}")
		end
	}

	def self.options_for_sorted_by
		[
			['BES Cyber System (a-z)', 'systems_asc'],
			['BES Cyber System (z-a)', 'systems_desc'],
			['BES Asset (a-z)', 'bes_asset_ls_asc'],
			['BES Asset (z-a)', 'bes_asset_ls_desc'],
			['Updated At (newest)', 'updated_at_desc'],
			['Updated At (oldest)', 'updated_at_asc'],
			['Created At (newest)', 'created_at_desc'],
			['Created At (oldest)', 'created_at_asc']
		]
	end

end
