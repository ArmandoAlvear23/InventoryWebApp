class BesAsset < ApplicationRecord

mount_uploader :proof, BesAssetUploader
serialize :proof, JSON 
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ['ID', 'Asset ID', 'Asset Type', 'Description', 'Commission Date', 'Decommission Date', 'Location', 'High Impact', 'Medium Impact', 'Low Impact', 'ERC', 'Dial-Up?', 'Region Operations', 'Function']
      BesAsset.all.each do |b|
       csv << [b.id, b.asset_id, b.asset_type, b.description, b.commission, b.decommission, b.location, b.high_impact, b.medium_impact, b.low_impact, b.erc, b.dial_up, b.region_op, b.register_func]
      end
    end
  end

	filterrific(
		default_filter_params: { sorted_by: 'created_at_asc' },
		available_filters: [
			:sorted_by,
			:search_query,
			:with_asset_type,
			:with_comm_at,
			:with_asset_rating,
			:with_high,
			:with_medium,
			:with_low,
		]
		)


	scope :with_asset_type, lambda { |types|
		where(asset_type: [*types])
	}

	scope :with_high, lambda { |flag|
    return nil  if 0 == flag # checkbox unchecked
    where(high_impact: 'True')
  }

  scope :with_medium, lambda { |flag|
    return nil  if 0 == flag # checkbox unchecked
    where(medium_impact: 'True')
  }

  scope :with_low, lambda { |flag|
    return nil  if 0 == flag # checkbox unchecked
    where(low_impact: 'True')
  }

	# always include the lower boundary for semi open intervals
	scope :with_comm_at, lambda { |reference_time|
		where('bes_assets.commission >= ?', reference_time)
	}


scope :search_query, lambda { |query|
return nil if query.blank?
terms = query.downcase.split(/\s+/)
terms = terms.map { |e| ('%'+e.gsub('*','%')+'%').gsub(/%+/, '%') }
num_or_conds = 2
where(
terms.map {
or_clauses = [
"LOWER(bes_assets.asset_id) LIKE ?",
"LOWER(bes_assets.description) LIKE ?"
].join(' OR ')
"(#{ or_clauses })"
}.join(' AND '),
*terms.map { |e| [e] * num_or_conds }.flatten
)
}




scope :sorted_by, lambda { |sort_option|
  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  case sort_option.to_s
  when /^created_at_/
    order("bes_assets.commission #{ direction }")
when /^removed_at_/
    order("bes_assets.decommission #{ direction }")
when /^assetid_/
    order("LOWER(bes_assets.asset_id) #{ direction }, LOWER(bes_assets.asset_type) #{ direction }")
when /^asset_type_/
    order("LOWER(bes_assets.asset_type) #{ direction }")
		#Added
		when /^added_/
			order("bes_assets.created_at #{ direction }")
		#Modified
		when /^fixed_/
			order("bes_assets.updated_at #{ direction }")
else
	raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
end

}

def self.options_for_sorted_by
	[
		['Asset ID (a-z)', 'assetid_asc'],
		['Asset ID (z-a)', 'assetid_desc'],
		['Commission (newest)', 'created_at_desc'],
		['Commission (oldest)', 'created_at_asc'],
		['Decommission (newest)', 'removed_at_desc'],
		['Decommission (oldest)', 'removed_at_asc'],
		['Asset Type (group)', 'asset_type_asc'],
		['Updated At (newest)', 'fixed_desc'],
		['Updated At (oldest)', 'fixed_asc'],
		['Created At (newest)', 'added_desc'],
		['Created At (oldest)', 'added_asc']
	]
end


def self.options_for_select
	order('LOWER(bes_assets.asset_type)').map { |e| [e.asset_type] }

end

has_many :bes_cyber_assets

end
