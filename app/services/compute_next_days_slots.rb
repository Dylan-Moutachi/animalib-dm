class ComputeNextDaysSlots
  def initialize(user:, start_date: Date.today, nb_of_days: 5)
    @user = user
    @days = [start_date]
    (nb_of_days - 1).times do |i|
      @days << @days.last.next_weekday
    end
  end

  def call
    @days.map do |day|
      {
        date: day,
        slots: ComputeDaySlots.new(bookings: day_bookings(day)).call
      }
    end
  end

  private

  def bookings
    @bookings ||= @user.bookings
  end

  def day_bookings(day)
    if bookings.loaded?
      bookings.filter { |booking| (day.beginning_of_day..day.end_of_day).cover?(booking.date) }
    else
      bookings.where(date: day.beginning_of_day..day.end_of_day)
    end
  end
end
