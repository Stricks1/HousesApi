class PlaceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location_type, :address, :city, :country, :daily_price

  has_many :images
end
