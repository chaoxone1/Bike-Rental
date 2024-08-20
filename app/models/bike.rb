class Bike < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  validates :description, length: { minimum: 10 }
  validates :description, :price, presence: true
end
