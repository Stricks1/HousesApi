class PlaceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :location_type, :address, :city, :country, :daily_price

  has_many :images
end
