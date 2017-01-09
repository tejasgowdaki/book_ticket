class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:home, :index ]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = current_user.bookings.where('cancled == ?', false)
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
     begin
      @booking = current_user.bookings.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to bookings_path, notice: "Record not found"
    end
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
     begin
      @booking = current_user.bookings.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to bookings_path, notice: "Record not found"
    end
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    @booking.booking_number = Booking.generate_booking_number
    @booking.cancled = false
    @booking.valid_ticket = true
    @booking.user_id = current_user.id

    respond_to do |format|
      if @booking.save
        format.html { redirect_to edit_booking_path(@booking), notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def cancel_booking
    booking = Booking.find(params[:booking_id])
    booking.update_attributes(cancled: true)
    redirect_to bookings_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
       begin
        @booking = current_user.bookings.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to bookings_path, notice: "Record not found"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:user_name, :airline_name, :travel_date, :booking_date, :user_id, :cancled, :valid_ticket, :class_type, :booking_number, food_ids: [])
    end
end
