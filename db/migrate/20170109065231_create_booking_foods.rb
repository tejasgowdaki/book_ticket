class CreateBookingFoods < ActiveRecord::Migration
  def change
    create_table :booking_foods do |t|
      t.integer :booking_id
      t.integer :food_id

      t.timestamps null: false
    end
  end
end
