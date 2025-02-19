class AddDateToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :date, :datetime
  end
end
