class ProfilesController < ApplicationController
  def show
    @animal = Animal.new
    @review = Review.new

    start_date = params.fetch(:start_date, Date.today).to_date
    @all_bookings_sorted = Booking.where(animal: current_user.animals).order(date: :desc)

    # For a monthly view:
    @bookings = current_user.bookings_for_animal.where(date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end

end
