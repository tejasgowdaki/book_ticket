class BookingFood < ActiveRecord::Base
	belongs_to :booking
	belongs_to :food
end
