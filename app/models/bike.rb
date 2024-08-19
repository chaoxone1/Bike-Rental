class Bike < ApplicationRecord
  belongs_to :user
end

validates :description, length: { minimum: 10 }
validates :description, :price, presence: true
