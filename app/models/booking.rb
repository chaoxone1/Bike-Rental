class Booking < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :bike

  validates :start_date, :end_date, :status, presence: true
end
