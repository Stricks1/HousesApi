class RentDate < ApplicationRecord
  belongs_to :place
  belongs_to :user

  def price_rent(days)
    return place.daily_price * days 
  end
end
