class BikesController < ApplicationController
  before_action :set_bike, only: [:show, :edit, :update, :destroy]

  def index
    @bikes = Bike.all
  end

  def edit
  end

  def update
    if @bike.update(bike_params)
      redirect_to @bike, notice: 'Bike was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bike = Bike.find(params[:id])
    @bike.destroy
    redirect_to_list_path(@bike.list)
  end

  def show
    @bike = Bike.find(params[:id])
    @booking = Booking.new
  end

  def new
    @bike = Bike.new
  end

  def create
    @bike = Bike.new(bike_params)
    @bike.user = current_user
    if @bike.save
      redirect_to @bike, notice: 'Bike was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_bike
    @bike = Bike.find(params[:id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def bike_params
    params.require(:bike).permit(:price, :description, :location, :user_id, :index_bikes_on_user_id, photos: [])
  end
end
