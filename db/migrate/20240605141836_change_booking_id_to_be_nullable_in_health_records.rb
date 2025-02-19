class ChangeBookingIdToBeNullableInHealthRecords < ActiveRecord::Migration[7.1]
  def change
    change_column_null :health_records, :booking_id, true
  end
end
