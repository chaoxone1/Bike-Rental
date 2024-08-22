class Bike < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :photos
  after_create :create_initial_booking

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  validates :description, length: { minimum: 10 }
  validates :description, :price, presence: true

  private

  def create_initial_booking
    # Create a booking with status 'new' and without an associated user
    Booking.create!(
      bike: self,
      start_date: Date.today, # or set a default value or leave nil if not required
      end_date: Date.today + 1.week, # or set a default value or leave nil if not required
      status: 'new'
    )
  end
end
