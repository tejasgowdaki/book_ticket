class Food < ActiveRecord::Base
	has_many :booking_foods
	has_many :bookings, through: :booking_foods
end
