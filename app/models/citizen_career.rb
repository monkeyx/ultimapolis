class CitizenCareer < ActiveRecord::Base
	
	belongs_to :citizen
	belongs_to :profession 
	validates :career_index, numericality: {only_integer: true}
	validates :term_length, numericality: {only_integer: true}
	# t.boolean :current
	

	default_scope ->{ order('career_index DESC') }
	
end
