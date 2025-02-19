class HealthRecordsController < ApplicationController
  before_action :set_record, only: [:update, :destroy]

  def index
    @animal = Animal.find(params[:animal_id])
    @healthrecords = @animal.health_records
    @healthrecord = HealthRecord.new
  end

  def new
    @animal = Animal.find(params[:animal_id])
    @healthrecord = HealthRecord.new
  end

  def create
    @animal = Animal.find(params[:animal_id])
    @healthrecord = HealthRecord.new(healthrecord_params)
    @healthrecord.animal = @animal
    if @healthrecord.save
      redirect_to animal_health_records_path(@animal), notice: 'Record has been created.'
    else
      render :new
    end
  end

  def edit
    @healthrecord = HealthRecord.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:booking_id])
    @animal = Animal.find(params[:animal_id])
    @healthrecord.update(healthrecord_params)
    redirect_to @healthrecord
  end

  def destroy
    @animal = @healthrecord.animal
    @healthrecord.destroy
    redirect_to animal_health_records_path(@animal), status: :see_other, notice: 'Record has been deleted.'
  end

  private

  def set_record
    @healthrecord = HealthRecord.find(params[:id])
  end

  def healthrecord_params
    params.require(:health_record).permit(:history, :animal_id)
  end
end
