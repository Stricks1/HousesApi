class Place < ApplicationRecord
  belongs_to :user
  has_many :rent_dates
  has_many :images, dependent: :destroy

  validates :location_type, presence: true, allow_blank: false
  validates :address, presence: true, allow_blank: false
  validates :city, presence: true, allow_blank: false
  validates :country, presence: true, allow_blank: false
  validates :daily_price, presence: true, allow_blank: false
end
