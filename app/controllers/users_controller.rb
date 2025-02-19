class UsersController < ApplicationController
  def index
    # @professionals = User.where.not(profession: nil)
    @professionals = User.includes(:bookings, photo_attachment: :blob).where.not(profession: nil)

    set_booking

    @professional = User.find_by(profession: params[:profession])
    #.order(:profession)


    if params[:query].present?
      sql_subquery = <<~SQL
        users.first_name ILIKE :query
        OR users.last_name ILIKE :query
      SQL
      @professionals = @professionals.where(sql_subquery, query: "%#{params[:query]}%")
    end

    if params[:profession].present?
      @professionals = @professionals.where("users.profession ILIKE ?", "%#{params[:profession]}%")
    end

    if params[:address].present?
      @professionals = @professionals.near(params[:address], 2)
      # @professionals = @professionals.where("users.address ILIKE ?", "%#{params[:address]}%")
      # @professionals_located = @professionals
    end

    @markers = @professionals.geocoded.map do |professional|
      {
        lat: professional.latitude,
        lng: professional.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { professional: professional }),
        marker_html: render_to_string(partial: "marker", locals: { professional: professional })
      }
    end
  end

  def show
    set_booking
    @professional = User.find(params[:id])
    @slots = ComputeNextDaysSlots.new(user: @professional).call
    # @bookings = @professional.bookings
    if @professional.present?
      @markers = [
        {
          lat: @professional.latitude,
          lng: @professional.longitude,
          info_window_html: render_to_string(partial: "info_window", locals: { professional: @professional }),
          marker_html: render_to_string(partial: "marker", locals: { professional: @professional })
        }
      ]
    end
  end

  private

  def set_booking
    @booking = Booking.new(date: params[:date])
  end
end
