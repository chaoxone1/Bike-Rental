class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @bikes_with_new_bookings = current_user.bikes.joins(:bookings).where(bookings: { status: 'new' }).distinct
    @pending_bookings = current_user.bookings.where(status: 'pending')
    @previous_bookings = current_user.bookings.where(status: 'booked')
  end

  def offers
    @user = current_user
    @bikes = @user.bikes
  end
end
