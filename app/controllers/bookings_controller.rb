class BookingsController < ApplicationController
  def index
    set_animal
    @bookings = @animal.bookings
    @review = Review.new
  end

  # def new
  #   set_professional
  #   @booking = Booking.new(date: params[:date])
  #   @reasons = ["Follow-up consultation", "Vaccination", "Sterilization", "Digestive diseases", "Trauma", "Other"]
  # end

  def new
    set_professional
    @booking = Booking.new(date: params[:date])
    render json: {
      html: render_to_string(
        partial: 'bookings/booking_form',
        locals: { professional: @professional, booking: @booking },
        formats: :html,
        layout: false
      )
    }.to_json
  end

  def create
    set_professional
    @booking = Booking.new(booking_params)
    @booking.user = @professional
    respond_to do |format|
      if @booking.save
        format.html { redirect_to profile_path }
        format.json
      else
        format.html { render "users/show", status: :unprocessable_entity }
        format.json
      end
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    set_animal
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    redirect_to animal_path(@animal)
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to profile_path, status: :see_other
  end

  private

  def set_professional
    @professional = User.find(params[:user_id])
  end

  def set_animal
    @animal = Animal.find(params[:animal_id])
  end

  def booking_params
    params.require(:booking).permit(:animal_id, :date, :reason)
  end
end
