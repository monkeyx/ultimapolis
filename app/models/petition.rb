class Petition < ActiveRecord::Base
	
	belongs_to :citizen 
	validates :name, presence: true
	validates :summary, presence: true
	# t.boolean :accepted

	before_validation :set_turn

	scope :open, -> { where(accepted: false )}
	scope :accepted, -> { where(accepted: true )}
	scope :for_citizen, -> { where(citizen_id: citizen.id )}

	default_scope ->{ order('cached_weighted_average DESC') }

	acts_as_commontable
	acts_as_votable

	def to_s
		name 
	end

	def set_turn
		self.turn ||= Global.singleton.turn
	end
end
