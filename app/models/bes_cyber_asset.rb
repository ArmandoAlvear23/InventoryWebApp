class BesCyberAsset < ApplicationRecord

	mount_uploader :proof, BesCyberAssetUploader
	serialize :proof, JSON 

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      BesCyberAsset.all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

	filterrific(
		default_filter_params: { sorted_by: 'created_at_asc'},
		available_filters: [
			:sorted_by,
			:search_query,
			:with_asset_id,
			:with_impact_rating,
			:with_ca_class,
			:with_ca_function,
			:with_os_firmware,
			:with_logging,
		]
		)


	scope :with_asset_id, lambda { |types|
		where(asset_id: [*types])
	}

	scope :with_impact_rating, lambda { |types|
		where(impact_rating: [*types])
	}

	scope :with_ca_class, lambda { |types|
		where(ca_classification: [*types])
	}

	scope :with_ca_function, lambda { |types|
		where(ca_function: [*types])
	}

	scope :with_os_firmware, lambda { |types|
		where(os_firmware: [*types])
	}

	scope :with_logging, lambda { |types|
		where(bcs_id: [*types])
	}

	scope :search_query, lambda { |query|
		return nil if query.blank?
		terms = query.downcase.split(/\s+/)
		terms = terms.map { |e| ('%'+e.gsub('*','%')+'%').gsub(/%+/, '%') }
		num_or_conds = 18
		where(
			terms.map{
				or_clauses = [
					"LOWER(bes_cyber_assets.ca_id) LIKE ?",
					"LOWER(bes_cyber_assets.ca_classification) LIKE ?",
					"LOWER(bes_cyber_assets.bcs_id) LIKE ?",
					"LOWER(bes_cyber_assets.asset_id) LIKE ?",
					"LOWER(bes_cyber_assets.ip_address) LIKE ?",
					"LOWER(bes_cyber_assets.esp_identifier) LIKE ?",
					"LOWER(bes_cyber_assets.ca_psp) LIKE ?",
					"LOWER(bes_cyber_assets.activation_date) LIKE ?",
					"LOWER(bes_cyber_assets.deactivation_date) LIKE ?",
					"LOWER(bes_cyber_assets.ca_function) LIKE ?",
					"LOWER(bes_cyber_assets.ca_other) LIKE ?",
					"LOWER(bes_cyber_assets.ca_vendor) LIKE ?",
					"LOWER(bes_cyber_assets.ca_model) LIKE ?",
					"LOWER(bes_cyber_assets.os_firmware) LIKE ?",
					"LOWER(bes_cyber_assets.os_other) LIKE ?",
					"LOWER(bes_cyber_assets.reg_entity_ncr) LIKE ?",
					"LOWER(bes_cyber_assets.region) LIKE ?",
					"LOWER(bes_cyber_assets.function) LIKE ?"
				].join( ' OR ')
				"(#{ or_clauses })"
			}.join(' AND '),
			*terms.map { |e| [e] * num_or_conds }.flatten
			)
	}

	scope :sorted_by, lambda { |sort_option|
		direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
		case sort_option.to_s
		#Activation Date
		when /^created_at_/
			order("bes_cyber_assets.activation_date #{ direction }")
		#De-Activation Date
		when /^removed_at_/
			order("bes_cyber_assets.deactivation_date #{ direction }")
		#Added
		when /^added_/
			order("bes_cyber_assets.created_at #{ direction }")
		#Modified
		when /^fixed_/
			order("bes_cyber_assets.updated_at #{ direction }")
		#Asset ID
		when /^asset_id_/
			order("LOWER(bes_cyber_assets.asset_id) #{ direction }")
		#Cyber Asset ID
		when /^ca_id_/
			order("LOWER(bes_cyber_assets.ca_id) #{ direction }")
		#Asset Function
		when /^ca_function_/
			order("LOWER(bes_cyber_assets.ca_function) #{ direction }")
		#Operating System
		when /^os_firmware_/
			order("LOWER(bes_cyber_assets.os_firmware) #{ direction }")
		#Model	
		when /^ca_model_/
			order("LOWER(bes_cyber_assets.ca_model) #{ direction }")
		#Vendor
		when /^ca_vendor_/
			order("LOWER(bes_cyber_assets.ca_vendor) #{ direction }")
		#Region
		when /^region_/
			order("LOWER(bes_cyber_assets.region) #{ direction }")
		#Cyber System
		when /^bcs_/
			order("LOWER(bes_cyber_assets.bcs_id) #{ direction }")
		else
			raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect}")
		end
	}

	def self.options_for_sorted_by
		[
			['Cyber Asset ID (a-z)', 'ca_id_asc'],
			['Cyber Asset ID (z-a)', 'ca_id_desc'],
			['Asset ID (a-z)', 'asset_id_asc'],
			['Asset ID (z-a)', 'asset_id_desc'],
			['Cyber System (a-z)', 'bcs_asc'],
			['Cyber System (z-a)', 'bcs_desc'],
			['Region (a-z)', 'region_asc'],
			['Region (z-a)', 'region_desc'],
			['Asset Function (a-z)', 'ca_function_asc'],
			['Asset Function (z-a)', 'ca_function_desc'],
			['Operating System (a-z)', 'os_firmware_asc'],
			['Operating System (z-a)', 'os_firmware_desc'],
			['Model (a-z)', 'ca_model_asc'],
			['Model (z-a)', 'ca_model_desc'],
			['Vendor(a-z)', 'ca_vendor_asc'],
			['Vendor (z-a)', 'ca_vendor_desc'],
			['Commission (newest)', 'created_at_asc'],
			['Commission (oldest)', 'created_at_desc'],
			['Decommission (newest)', 'removed_asc'],
			['Decommission (oldest)', 'removed_desc'],
			['Updated At (newest)', 'fixed_desc'],
			['Updated At (oldest)', 'fixed_asc'],
			['Created At (newest)', 'added_desc'],
			['Created At (oldest)', 'added_asc']
		]
	end

	def self.options_for_select
		order('LOWER(bes_cyber_assets.asset_id)').map { |e| [e.asset_id] }
	end

	belongs_to :bes_assets, :optional => true
	
end
