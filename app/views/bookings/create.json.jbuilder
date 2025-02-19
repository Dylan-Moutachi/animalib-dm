if @booking.persisted?
  json.form render(partial: "bookings/booking_form", formats: :html, locals: {booking: Booking.new})
  json.inserted_item render(partial: "bookings/booking", formats: :html, locals: {booking: @booking})
else
  json.form render(partial: "bookings/booking_form", formats: :html, locals: {booking: @booking})
end
