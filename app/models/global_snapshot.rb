class GlobalSnapshot < ActiveRecord::Base
	
	validates :infrastructure, numericality: {only_integer: true}
	validates :grid, numericality: {only_integer: true}
	validates :power, numericality: {only_integer: true}
	validates :stability, numericality: {only_integer: true}
	validates :climate, numericality: {only_integer: true}
	validates :liberty, numericality: {only_integer: true}
	validates :security, numericality: {only_integer: true}
	validates :borders, numericality: {only_integer: true}
	validates :turn, numericality: {only_integer: true}
	validates :inflation, numericality: {only_integer: true}
	validates :citizens, numericality: {only_integer: true}
	validates :gdp, numericality: {only_integer: true}

end
