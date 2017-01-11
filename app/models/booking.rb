class Booking < ActiveRecord::Base

	belongs_to :user
	has_many :booking_foods
	has_many :foods, through: :booking_foods
	has_many :booking_meals
	has_many :meals, through: :booking_meals

	validates_presence_of :user_name, :airline_name, :travel_date, :booking_date, :booking_number, :class_type
	validates_length_of :booking_number, is: 6
	validates_uniqueness_of :booking_number

	after_create :mark_old_and_cancelled_bookings_as_invalid

	def mark_old_and_cancelled_bookings_as_invalid
		Booking.where('travel_date < ?', Date.today - 2.years).pluck(:valid_ticket).map { |v| v = false }
		Booking.where('cancled = ? and travel_date < ?', true, Date.today - 3.months ).pluck(:valid_ticket).map { |v| v = false }
	end



	def self.generate_booking_number		
		user_defined_numbers = ["SELFIE", "BARNEY", "RACHEL", "MONICA", "ETIHAD", "AMAZON"]
		
		while true
			response = HTTParty.get('https://book-num-api.herokuapp.com/api/v1/bookings/number')
			book_number = response["booking_number"]

			if !(user_defined_numbers.find {|a| a == book_number})
				if !(Booking.all.where('valid_ticket = ?', true).pluck(:booking_number).find {|a| a == book_number})
					if !(Booking.last.nil?)
						if !(Booking.last.booking_number.include? book_number[0..2])
							break
						end
					else
						break
					end
				end			
			end
			
		end
		return book_number
	end
=begin
	def self.generate_number
		first_three = Array.new(3){rand(10..35).to_s(36)}.join.upcase
		while true
			if first_three == "EKA"
				first_three = Array.new(3){rand(10..35).to_s(36)}.join.upcase
			elsif Booking.last.nil?
					break
			elsif Booking.last.booking_number.include? first_three
				first_three = Array.new(3){rand(10..35).to_s(36)}.join.upcase
			else
				break
			end
		end
		last_three = Array.new(3){rand(36).to_s(36)}.join.upcase
		return first_three + last_three
	end
=end
end
