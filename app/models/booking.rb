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
		book_number = generate_number
		while true
			if user_defined_numbers.find {|a| a == book_number}
				book_number = generate_number
			elsif Booking.all.where('valid_ticket = ?', true).pluck(:booking_number).find {|a| a == book_number}
				book_number = generate_number
			else					
				break
			end
		end
		return book_number
	end

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
	
end
