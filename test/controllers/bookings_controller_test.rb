require 'test_helper'

class BookingsControllerTest < ActionController::TestCase
  setup do
    @booking = bookings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create booking" do
    assert_difference('Booking.count') do
      post :create, booking: { airline_name: @booking.airline_name, booking_date: @booking.booking_date, cancled: @booking.cancled, class_type: @booking.class_type, travel_date: @booking.travel_date, user_id: @booking.user_id, user_name: @booking.user_name, valid_ticket: @booking.valid_ticket }
    end

    assert_redirected_to booking_path(assigns(:booking))
  end

  test "should show booking" do
    get :show, id: @booking
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @booking
    assert_response :success
  end

  test "should update booking" do
    patch :update, id: @booking, booking: { airline_name: @booking.airline_name, booking_date: @booking.booking_date, cancled: @booking.cancled, class_type: @booking.class_type, travel_date: @booking.travel_date, user_id: @booking.user_id, user_name: @booking.user_name, valid_ticket: @booking.valid_ticket }
    assert_redirected_to booking_path(assigns(:booking))
  end

  test "should destroy booking" do
    assert_difference('Booking.count', -1) do
      delete :destroy, id: @booking
    end

    assert_redirected_to bookings_path
  end
end
