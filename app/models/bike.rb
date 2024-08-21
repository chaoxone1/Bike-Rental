class Bike < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :description, length: { minimum: 10 }
  validates :description, :price, presence: true
end
