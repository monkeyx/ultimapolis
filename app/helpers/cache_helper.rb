module CacheHelper
	def cache_key_for_name(name)
		return unless name
		if current_citizen
			"#{name}-citizen-#{current_citizen.id}-#{current_citizen.updated_at}"
		elsif current_user
			"#{name}-#{current_user.id}-user-#{current_user.id}-#{current_user.updated_at}"
		else
			name
		end
	end

	def cache_key_for_model(model)
		cache_key_for_name(model ? "#{model.class.name}-#{model.id}-#{model.updated_at}" : 'nil')
	end

	def cache_key_for_collection(name, collection)
		return unless collection
		count = collection.count
		max_updated_at = collection.maximum(:updated_at).try(:utc).try(:to_s, :number)
		"#{name}/all-#{count}-#{max_updated_at}"
	end
end