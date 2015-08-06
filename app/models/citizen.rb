class Citizen < ActiveRecord::Base
# t.boolean :email_notifications
# t.boolean :daily_updates
# t.boolean :instant_updates
# t.integer :credits
# t.integer :home_district_id
# t.integer :current_profession_id
# t.integer :profession_rank
# t.integer :current_project_id
# t.string :icon
# t.integer :user_id

	validates :credits, numericality: {only_integer: true}
	belongs_to :home_district, class_name: 'District'
	belongs_to :current_profession, class_name: 'Profession'
	validates :profession_rank, numericality: {only_integer: true}
	belongs_to :user

	has_many :citizen_careers
	has_many :citizen_equipment
	has_many :citizen_skills
	has_many :citizen_trade_goods
	has_many :facilities
	has_many :projects, foreign_key: 'leader_id'
	has_many :project_members

	

end
