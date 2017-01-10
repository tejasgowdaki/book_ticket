class FoodsController < ApplicationController

	def new
		@food = Food.new		
	end

	def create
		@food = Food.new(food_param)
		if @food.save
			redirect_to bookings_home_path, notice: "Successfully created food"
		else
			render action: "new"
		end
	end

	private

	def food_param
		params[:food].permit(:name)
	end

end
