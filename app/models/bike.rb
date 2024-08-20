class Bike < ApplicationRecord
  belongs_to :user
  # has_one_attached :photo
  validates :description, length: { minimum: 10 }
  validates :description, :price, presence: true
end
