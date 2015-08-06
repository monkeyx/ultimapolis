class CitizenCareer < ActiveRecord::Base
# t.integer :citizen_id
# t.integer :profession_id
# t.integer :career_index
# t.integer :term_length
# t.boolean :current
	
	belongs_to :citizen
	belongs_to :profession 
	validates :career_index, numericality: {only_integer: true}
	validates :term_length, numericality: {only_integer: true}
end
