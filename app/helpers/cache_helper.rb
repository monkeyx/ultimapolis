module CacheHelper
	def cache_key_for_collection(name, collection)
		return unless collection
		count = collection.count
		max_updated_at = collection.maximum(:updated_at).try(:utc).try(:to_s, :number)
		"#{name}/all-#{count}-#{max_updated_at}"
	end
end