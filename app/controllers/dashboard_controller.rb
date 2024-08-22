# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @bikes_with_new_bookings = current_user.bikes.joins(:bookings).where(bookings: { status: 'new' }).distinct
    @pending_bookings = current_user.bookings.where(status: 'pending')
    @open_requests = current_user.bikes.joins(:bookings).where(bookings: { status: 'pending' }).distinct
  end

  def offers
    @user = current_user
    @bikes = @user.bikes
  end

  def accept_booking
    booking = current_user.bikes.joins(:bookings).find_by(bookings: { id: params[:id] }).bookings.first
    if booking.update(status: 'accepted')
      flash[:notice] = "Booking accepted."
    else
      flash[:alert] = "Unable to accept booking."
    end
    redirect_to dashboard_path
  end

  def decline_booking
    booking = current_user.bikes.joins(:bookings).find_by(bookings: { id: params[:id] }).bookings.first
    if booking.update(status: 'declined')
      flash[:notice] = "Booking declined."
    else
      flash[:alert] = "Unable to decline booking."
    end
    redirect_to dashboard_path
  end
end
