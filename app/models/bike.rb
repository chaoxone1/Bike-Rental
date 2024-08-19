class Bike < ApplicationRecord
  belongs_to :user

  validates :description, length: { minimum: 10 }
  validates :description, :price, presence: true

  has_one_attached :photo
end
