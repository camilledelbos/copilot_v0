class Route < ActiveRecord::Base

	has_many :stages
	belongs_to :travel

	accepts_nested_attributes_for :stages

end
