class BikesController < ApplicationController
  before_action :set_bike, only: [:show, :edit, :update, :destroy, :book]
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @bikes = Bike.joins(:bookings)
                  .where(bookings: { status: 'new' })
                  .distinct

    @markers = @bikes.map do |bike|
      {
        lat: bike.latitude,
        lng: bike.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { bike: bike }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def edit
  end

  def book
    # Check if there's already a pending booking for this bike
    existing_booking = @bike.bookings.find_by(status: 'pending')
    if existing_booking
      flash[:alert] = 'This bike has already been booked.'
      redirect_to @bike and return
    end

    # Find or create a booking for this bike
    @booking = @bike.bookings.find_or_initialize_by(status: 'new')

    if @booking.update(user: current_user, status: 'pending')
      flash[:notice] = 'Booking confirmed!'
      redirect_to bikes_path # Redirect to the index page
    else
      flash[:alert] = 'Unable to confirm booking.'
      redirect_to @bike # Redirect back to the bike's show page in case of an error
    end
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
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Bike not found."
    redirect_to root_path
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def bike_params
    params.require(:bike).permit(:price, :description, :user_id, :index_bikes_on_user_id, photos: [])
  end
end
