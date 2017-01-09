class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :user_name
      t.string :airline_name
      t.date :travel_date
      t.date :booking_date
      t.integer :user_id
      t.boolean :cancled
      t.boolean :valid_ticket
      t.string :class_type

      t.timestamps null: false
    end
  end
end
