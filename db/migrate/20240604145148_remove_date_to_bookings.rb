class RemoveDateToBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :date
  end
end
