class RentDate < ApplicationRecord
  belongs_to :place
  belongs_to :user

  scope :between, ->(place_id, start_date, end_date) { 
    where('place_id= ? AND ((start_date >= ? AND start_date <= ?) OR (end_date >= ? AND end_date <= ?))',
    place_id,
    start_date,
    end_date,
    start_date,
    end_date)
  }

  def price_rent(days)
    place.daily_price * days
  end
end
